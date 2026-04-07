import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/services/building_service.dart';

/// Real-time countdown timer widget for building upgrades
class CountdownTimer extends ConsumerWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingState = ref.watch(buildingStateProvider);
    
    return buildingState.when(
      data: (state) {
        if (!state.hasActiveUpgrade) {
          return _buildNoActiveUpgrade(context);
        }
        
        return _buildActiveTimer(
          context,
          buildingName: state.buildingName ?? 'Bina',
          currentLevel: state.currentLevel ?? 1,
          newLevel: state.newLevel ?? 2,
          timeRemaining: state.timeRemaining ?? '00:00:00',
        );
      },
      loading: () => _buildLoading(context),
      error: (error, stack) => _buildError(context, error.toString()),
    );
  }

  Widget _buildNoActiveUpgrade(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_off,
            color: Colors.grey[600],
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Aktif Yükseltme Yok',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bir bina yükseltmeye başladığında\nburada geri sayım görünecek',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTimer(
    BuildContext context, {
    required String buildingName,
    required int currentLevel,
    required int newLevel,
    required String timeRemaining,
  }) {
    // Parse time for visual indicators
    final parts = timeRemaining.split(':');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;
    
    // Calculate progress (0.0 to 1.0)
    final totalSeconds = (hours * 3600) + (minutes * 60) + seconds;
    final maxTime = 3600; // Assume max 1 hour for progress calculation
    final progress = 1.0 - (totalSeconds / maxTime).clamp(0.0, 1.0);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.titaniumColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.titaniumColor.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.upgrade,
                    color: AppTheme.titaniumColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'YÜKSELTME DEVAM EDİYOR',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.titaniumColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildProgressIndicator(progress),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Building info
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.titaniumColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.factory,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 12),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buildingName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Seviye $currentLevel → $newLevel',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Countdown timer
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.quantumFuelColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'KALAN SÜRE',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                    letterSpacing: 1,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Large timer display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeUnit(context, hours.toString().padLeft(2, '0'), 'SAAT'),
                    _buildTimeSeparator(context),
                    _buildTimeUnit(context, minutes.toString().padLeft(2, '0'), 'DAKİKA'),
                    _buildTimeSeparator(context),
                    _buildTimeUnit(context, seconds.toString().padLeft(2, '0'), 'SANİYE'),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Progress bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[800],
                  color: AppTheme.titaniumColor,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Speed up with credits
                    _showSpeedUpDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.creditColor,
                    side: BorderSide(color: AppTheme.creditColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flash_on, size: 16),
                      SizedBox(width: 6),
                      Text('HIZLANDIR'),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Cancel upgrade
                    _showCancelDialog(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, size: 16),
                      SizedBox(width: 6),
                      Text('İPTAL ET'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double progress) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.titaniumColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 2,
            color: AppTheme.titaniumColor,
            backgroundColor: Colors.transparent,
          ),
          Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 6,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(BuildContext context, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppTheme.titaniumColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.titaniumColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monospace',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[500],
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSeparator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: AppTheme.titaniumColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red[900]!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(height: 8),
          Text(
            'Timer Hatası',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.red[200],
            ),
          ),
        ],
      ),
    );
  }

  void _showSpeedUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yükseltmeyi Hızlandır'),
        content: const Text('Yükseltmeyi hemen tamamlamak için 50 kredi harcayacaksın. Onaylıyor musun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İPTAL'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement speed up logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yükseltme hızlandırıldı!')),
              );
            },
            child: const Text('HIZLANDIR'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yükseltmeyi İptal Et'),
        content: const Text('Yükseltmeyi iptal edersen harcanan kaynakların %50\'si iade edilecek. Onaylıyor musun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('VAZGEÇ'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement cancel logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Yükseltme iptal edildi, kaynaklar iade edildi.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('İPTAL ET'),
          ),
        ],
      ),
    );
  }
}