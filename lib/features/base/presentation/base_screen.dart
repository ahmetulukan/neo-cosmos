import 'package:flutter/material.dart';
import '../widgets/countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/resource_service.dart';
import '../widgets/resource_display.dart';
import '../widgets/building_card.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/scenic_background.dart';
import '../widgets/gameplay_guide.dart';

class BaseScreen extends ConsumerStatefulWidget {
  const BaseScreen({super.key});

  @override
  ConsumerState<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends ConsumerState<BaseScreen> {
  int _selectedIndex = 0;

  int _titanium = GameConstants.initialTitanium;
  int _quantumFuel = GameConstants.initialQuantumFuel;
  final int _credits = GameConstants.initialCredits;
  final int _health = GameConstants.initialHealth;
  final int _energy = 75;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
    _initializeResources();
  }

  @override
  void dispose() {
    // Clean up resource timer
    final resourceService = ref.read(resourceServiceProvider);
    resourceService.dispose();
    super.dispose();
  }

  Future<void> _initializeAuth() async {
    final authService = ref.read(authServiceProvider);
    
    // Check if user is already signed in
    if (!authService.isSignedIn) {
      // Sign in anonymously
      final user = await authService.signInAnonymously();
      if (user != null) {
        print('✅ User signed in anonymously: ${user.uid}');
        
        // Initialize user data
        await authService.initializeUserData(user.uid);
        
        // Show welcome message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hoş geldin, Uzay Kaşifi #${user.uid.substring(0, 6)}!'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } else {
      print('✅ User already signed in: ${authService.userId}');
    }
  }

  void _initializeResources() {
    final resourceService = ref.read(resourceServiceProvider);
    resourceService.initializeResourceProduction();
    print('✅ Resource production system started');
  }

  String _heroForTab(int index) {
    switch (index) {
      case 0:
        return AssetPaths.heroHubPrimary;
      case 1:
        return AssetPaths.heroInventory;
      case 2:
        return AssetPaths.heroExploration;
      case 3:
        return AssetPaths.heroCombat;
      case 4:
        return AssetPaths.heroMeta;
      default:
        return AssetPaths.heroHubPrimary;
    }
  }

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  void _onUpgradeBuilding(String buildingId, String displayName) {
    final costs = GameConstants.buildingCosts[buildingId];
    final ti = costs?['titanium'] ?? 0;
    final qf = costs?['quantumFuel'] ?? 0;
    if (_titanium < ti || _quantumFuel < qf) {
      _toast(
        'Kaynak yetersiz: $displayName için $ti Titan ve $qf Quantum Yakıt gerekli.',
      );
      return;
    }
    setState(() {
      _titanium -= ti;
      _quantumFuel -= qf;
    });
    _toast('$displayName yükseltmesi kuyruğa alındı (yerel demo).');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Neo Cosmos'),
        backgroundColor: Colors.black.withValues(alpha: 0.35),
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Nasıl oynanır?',
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () => showGameplayGuide(context),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ScenicBackground(assetPath: _heroForTab(_selectedIndex)),
          ),
          Column(
            children: [
              _HudPanel(
                child: const ResourceDisplay(),
              ),
              Expanded(child: _buildTabBody()),
            ],
          ),
        ],
      ),
      bottomNavigationBar: GameNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildTabBody() {
    switch (_selectedIndex) {
      case 0:
        return BaseOverviewScreen(
          onUpgrade: _onUpgradeBuilding,
          onSpeedUp: () => _toast(
            'Hızlandırma: yakında kredi harcayarak süre kısaltılacak.',
          ),
        );
      case 1:
        return PlaceholderScreen(
          title: 'Envanter',
          subtitle: 'Eşyalar ve kaynak stack’leri burada listelenecek.',
          heroAsset: AssetPaths.heroInventory,
        );
      case 2:
        return PlaceholderScreen(
          title: 'Keşif',
          subtitle: 'Sektör seçimi ve AI destekli olaylar bu sekmede olacak.',
          heroAsset: AssetPaths.heroExploration,
        );
      case 3:
        return PlaceholderScreen(
          title: 'Savaş',
          subtitle: 'Filo ve savunma UI’si henüz bağlanmadı.',
          heroAsset: AssetPaths.heroCombat,
        );
      case 4:
        return PlaceholderScreen(
          title: 'Ayarlar',
          subtitle: 'Ses, hesap ve bildirimler için yer ayrıldı.',
          heroAsset: AssetPaths.heroMeta,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _HudPanel extends StatelessWidget {
  const _HudPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0F1328).withValues(alpha: 0.72),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.titaniumColor.withValues(alpha: 0.25),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class BaseOverviewScreen extends StatelessWidget {
  const BaseOverviewScreen({
    super.key,
    required this.onUpgrade,
    required this.onSpeedUp,
  });

  final void Function(String buildingId, String displayName) onUpgrade;
  final VoidCallback onSpeedUp;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _PlanetAvatar(path: AssetPaths.planetAlpha),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gezegen Alpha',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Seviye 1 • Nüfus: 1.250',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: 0.65,
                    backgroundColor: Colors.grey.shade900,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Üretim verimliliği: %65 (demo)',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
                    const SizedBox(height: 20),
          
          // Gün 4: Gerçek zamanlı yükseltme sayacı
          CountdownTimer(),
          
          const SizedBox(height: 20),Text(
            'Binalar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              BuildingCard(
                buildingId: 'mine',
                name: 'Maden Ocağı',
                level: 1,
                icon: AssetPaths.mineIcon,
                productionRate: '10 Titan/saat',
                upgradeCost: '100 Titan',
                upgradeTime: '5 dk',
                onUpgrade: () => onUpgrade('mine', 'Maden Ocağı'),
              ),
              BuildingCard(
                buildingId: 'refinery',
                name: 'Rafineri',
                level: 1,
                icon: AssetPaths.refineryIcon,
                productionRate: '5 Quantum Yakıt/saat',
                upgradeCost: '150 Titan',
                upgradeTime: '10 dk',
                onUpgrade: () => onUpgrade('refinery', 'Rafineri'),
              ),
              BuildingCard(
                buildingId: 'command_center',
                name: 'Komuta Merkezi',
                level: 1,
                icon: AssetPaths.commandCenterIcon,
                productionRate: 'Filo kapasitesi +5',
                upgradeCost: '300 Titan',
                upgradeTime: '30 dk',
                onUpgrade: () => onUpgrade('command_center', 'Komuta Merkezi'),
              ),
              BuildingCard(
                buildingId: 'research_lab',
                name: 'Araştırma Laboratuvarı',
                level: 1,
                icon: AssetPaths.researchLabIcon,
                productionRate: 'Araştırma hızı +%10',
                upgradeCost: '500 Titan',
                upgradeTime: '1 saat',
                onUpgrade: () => onUpgrade('research_lab', 'Araştırma Laboratuvarı'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktif yükseltmeler',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(AssetPaths.mineIcon),
                  ),
                  title: const Text('Maden Ocağı → Seviye 2'),
                  subtitle: const Text('Kalan: 04:32 (demo)'),
                  trailing: FilledButton(
                    onPressed: onSpeedUp,
                    child: const Text('Hızlandır'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanetAvatar extends StatelessWidget {
  const _PlanetAvatar({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.titaniumColor.withValues(alpha: 0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.titaniumColor.withValues(alpha: 0.25),
            blurRadius: 12,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF1D1E33)),
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1D1E33).withValues(alpha: 0.88),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.heroAsset,
  });

  final String title;
  final String subtitle;
  final String heroAsset;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    heroAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const ColoredBox(color: Color(0xFF1D1E33)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
