import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/services/resource_service.dart';

class ResourceDisplay extends ConsumerWidget {
  const ResourceDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch resource changes
    final resourcesAsync = ref.watch(combinedResourcesProvider);
    
    return resourcesAsync.when(
      data: (resources) {
        return _buildResourceDisplay(
          context,
          titanium: resources.titanium,
          quantumFuel: resources.quantumFuel,
          credits: resources.credits,
          productionRates: resources.productionRates,
        );
      },
      loading: () => _buildLoadingDisplay(context),
      error: (error, stack) => _buildErrorDisplay(context, error.toString()),
    );
  }

  Widget _buildResourceDisplay(
    BuildContext context, {
    required int titanium,
    required int quantumFuel,
    required int credits,
    required Map<String, int> productionRates,
  }) {
    // Health and energy are static for now
    const health = 100;
    const energy = 75;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Top row: Titanium, Quantum Fuel, Credits
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ResourceItem(
                icon: Icons.diamond,
                value: titanium,
                label: 'Titanium',
                color: AppTheme.titaniumColor,
                productionRate: productionRates['titanium'] ?? 0,
              ),
              _ResourceItem(
                icon: Icons.local_gas_station,
                value: quantumFuel,
                label: 'Quantum Fuel',
                color: AppTheme.quantumFuelColor,
                productionRate: productionRates['quantumFuel'] ?? 0,
              ),
              _ResourceItem(
                icon: Icons.monetization_on,
                value: credits,
                label: 'Kredi',
                color: AppTheme.creditColor,
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Bottom row: Health and Energy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ResourceItem(
                icon: Icons.favorite,
                value: health,
                label: 'Sağlık',
                color: AppTheme.healthColor,
                maxValue: 100,
                showProgress: true,
              ),
              _ResourceItem(
                icon: Icons.bolt,
                value: energy,
                label: 'Enerji',
                color: AppTheme.energyColor,
                maxValue: 100,
                showProgress: true,
              ),
              // Production rates display
              _ProductionRatesDisplay(
                titaniumRate: productionRates['titanium'] ?? 0,
                fuelRate: productionRates['quantumFuel'] ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorDisplay(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardTheme.color,
        border: Border(
          bottom: BorderSide(
            color: Colors.red[800]!,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color color;
  final int? maxValue;
  final bool showProgress;
  final int? productionRate;

  const _ResourceItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.maxValue,
    this.showProgress = false,
    this.productionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatNumber(value),
                  style: AppTheme.resourceTextStyle.copyWith(color: color),
                ),
                if (productionRate != null && productionRate! > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    '+${_formatNumber(productionRate!)}/s',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.green,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        
        if (showProgress && maxValue != null) ...[
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              value: value / maxValue!,
              backgroundColor: Colors.grey[800],
              color: color,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
        
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

class _ProductionRatesDisplay extends StatelessWidget {
  final int titaniumRate;
  final int fuelRate;

  const _ProductionRatesDisplay({
    required this.titaniumRate,
    required this.fuelRate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Üretim',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.diamond, color: AppTheme.titaniumColor, size: 12),
            const SizedBox(width: 2),
            Text(
              '+$titaniumRate/s',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppTheme.titaniumColor,
                fontSize: 10,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.local_gas_station, color: AppTheme.quantumFuelColor, size: 12),
            const SizedBox(width: 2),
            Text(
              '+$fuelRate/s',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppTheme.quantumFuelColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}