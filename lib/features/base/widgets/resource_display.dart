import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ResourceDisplay extends StatelessWidget {
  final int titanium;
  final int quantumFuel;
  final int credits;
  final int health;
  final int energy;

  const ResourceDisplay({
    super.key,
    required this.titanium,
    required this.quantumFuel,
    required this.credits,
    required this.health,
    required this.energy,
  });

  @override
  Widget build(BuildContext context) {
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
              ),
              _ResourceItem(
                icon: Icons.local_gas_station,
                value: quantumFuel,
                label: 'Quantum Fuel',
                color: AppTheme.quantumFuelColor,
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
              // Empty space for alignment
              const SizedBox(width: 100),
            ],
          ),
        ],
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

  const _ResourceItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.maxValue,
    this.showProgress = false,
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
            Text(
              _formatNumber(value),
              style: AppTheme.resourceTextStyle.copyWith(color: color),
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