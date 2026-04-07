import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../models/base_model.dart';
import '../../models/user_model.dart';
import '../constants.dart';

/// Building upgrade service for Neo Cosmos
class BuildingService {
  final FirebaseFirestore _firestore;
  final Box<UserModel> _userBox;
  final Box<BaseModel> _baseBox;
  
  BuildingService(this._firestore, this._userBox, this._baseBox);
  
  /// Get current base data
  BaseModel? get currentBase {
    return _baseBox.get('current_base');
  }
  
  /// Get current user data
  UserModel? get currentUser {
    return _userBox.get('current_user');
  }
  
  /// Calculate upgrade cost for a building
  Map<String, int> calculateUpgradeCost(String buildingId, int currentLevel) {
    // Base costs increase exponentially
    final baseTitanium = GameConstants.baseBuildingCosts[buildingId]?.titanium ?? 100;
    final baseFuel = GameConstants.baseBuildingCosts[buildingId]?.quantumFuel ?? 50;
    
    // Exponential scaling: cost = base * (1.5 ^ level)
    final titaniumCost = (baseTitanium * _exponentialFactor(currentLevel)).round();
    final fuelCost = (baseFuel * _exponentialFactor(currentLevel)).round();
    final creditCost = (titaniumCost * 0.1).round(); // 10% of titanium cost
    
    return {
      'titanium': titaniumCost,
      'quantumFuel': fuelCost,
      'credits': creditCost,
      'timeSeconds': _calculateUpgradeTime(currentLevel),
    };
  }
  
  double _exponentialFactor(int level) {
    return 1.5 * level.toDouble();
  }
  
  int _calculateUpgradeTime(int currentLevel) {
    // Base 30 seconds, +15 seconds per level
    return 30 + (currentLevel * 15);
  }
  
  /// Check if user can afford building upgrade
  bool canAffordUpgrade(String buildingId, int currentLevel) {
    final costs = calculateUpgradeCost(buildingId, currentLevel);
    final user = currentUser;
    
    if (user == null) return false;
    
    return user.titanium >= costs['titanium']! &&
           user.quantumFuel >= costs['quantumFuel']! &&
           user.credits >= costs['credits']!;
  }
  
  /// Start building upgrade
  Future<bool> startUpgrade({
    required String buildingId,
    required String buildingName,
    required int currentLevel,
  }) async {
    if (!canAffordUpgrade(buildingId, currentLevel)) {
      return false;
    }
    
    final costs = calculateUpgradeCost(buildingId, currentLevel);
    final user = currentUser;
    final base = currentBase;
    
    if (user == null || base == null) return false;
    
    try {
      // 1. Spend resources
      final updatedUser = user.copyWith(
        titanium: user.titanium - costs['titanium']!,
        quantumFuel: user.quantumFuel - costs['quantumFuel']!,
        credits: user.credits - costs['credits']!,
      );
      
      _userBox.put('current_user', updatedUser);
      
      // 2. Create upgrade record with server timestamp
      final upgradeEndTime = DateTime.now().add(Duration(seconds: costs['timeSeconds']!));
      
      // In real implementation, this would use Firestore with serverTimestamp
      // For now, store locally
      final upgradeData = {
        'buildingId': buildingId,
        'buildingName': buildingName,
        'currentLevel': currentLevel,
        'newLevel': currentLevel + 1,
        'startTime': DateTime.now().toIso8601String(),
        'endTime': upgradeEndTime.toIso8601String(),
        'status': 'upgrading',
      };
      
      _baseBox.put('active_upgrade', upgradeData);
      
      // 3. Start upgrade timer
      _startUpgradeTimer(buildingId, buildingName, currentLevel, upgradeEndTime);
      
      print('🏗️ Building upgrade started: $buildingName (L$currentLevel → L${currentLevel + 1})');
      return true;
      
    } catch (e) {
      print('❌ Upgrade failed: $e');
      return false;
    }
  }
  
  /// Complete building upgrade
  Future<void> completeUpgrade(String buildingId) async {
    final upgradeData = _baseBox.get('active_upgrade');
    if (upgradeData == null) return;
    
    final buildingId = upgradeData['buildingId'];
    final newLevel = upgradeData['newLevel'];
    
    // Update building level in base
    final base = currentBase;
    if (base != null) {
      // In real implementation, update Firestore
      // For now, update local cache
      final updatedBase = base.copyWith(
        // This would update specific building level
        // For simplicity, just increment a counter
        totalBuildings: base.totalBuildings + 1,
      );
      
      _baseBox.put('current_base', updatedBase);
    }
    
    // Clear active upgrade
    _baseBox.delete('active_upgrade');
    
    print('✅ Building upgrade completed: $buildingId → L$newLevel');
  }
  
  /// Check for completed upgrades
  void checkCompletedUpgrades() {
    final upgradeData = _baseBox.get('active_upgrade');
    if (upgradeData == null) return;
    
    final endTime = DateTime.parse(upgradeData['endTime']);
    if (DateTime.now().isAfter(endTime)) {
      completeUpgrade(upgradeData['buildingId']);
    }
  }
  
  void _startUpgradeTimer(
    String buildingId,
    String buildingName,
    int currentLevel,
    DateTime endTime,
  ) {
    // Timer to check for completion
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (DateTime.now().isAfter(endTime)) {
        completeUpgrade(buildingId);
        timer.cancel();
      }
    });
  }
  
  /// Get active upgrade info
  Map<String, dynamic>? getActiveUpgrade() {
    return _baseBox.get('active_upgrade');
  }
  
  /// Get time remaining for active upgrade
  Duration? getUpgradeTimeRemaining() {
    final upgradeData = getActiveUpgrade();
    if (upgradeData == null) return null;
    
    final endTime = DateTime.parse(upgradeData['endTime']);
    final now = DateTime.now();
    
    if (now.isAfter(endTime)) {
      return Duration.zero;
    }
    
    return endTime.difference(now);
  }
  
  /// Format time remaining as string (HH:MM:SS)
  String formatTimeRemaining(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    
    return '$hours:$minutes:$seconds';
  }
  
  /// Cancel active upgrade (with partial refund)
  Future<bool> cancelUpgrade() async {
    final upgradeData = getActiveUpgrade();
    if (upgradeData == null) return false;
    
    // Refund 50% of resources
    final costs = calculateUpgradeCost(
      upgradeData['buildingId'],
      upgradeData['currentLevel'],
    );
    
    final user = currentUser;
    if (user == null) return false;
    
    final refundTitanium = (costs['titanium']! * 0.5).round();
    final refundFuel = (costs['quantumFuel']! * 0.5).round();
    final refundCredits = (costs['credits']! * 0.5).round();
    
    final updatedUser = user.copyWith(
      titanium: user.titanium + refundTitanium,
      quantumFuel: user.quantumFuel + refundFuel,
      credits: user.credits + refundCredits,
    );
    
    _userBox.put('current_user', updatedUser);
    _baseBox.delete('active_upgrade');
    
    print('🔄 Upgrade cancelled: 50% refund applied');
    return true;
  }
}

/// Riverpod provider for BuildingService
final buildingServiceProvider = Provider<BuildingService>((ref) {
  final firestore = FirebaseFirestore.instance;
  final userBox = Hive.box<UserModel>('user_data');
  final baseBox = Hive.box<BaseModel>('base_data');
  return BuildingService(firestore, userBox, baseBox);
});

/// Riverpod provider for active upgrade
final activeUpgradeProvider = Provider<Map<String, dynamic>?>((ref) {
  final buildingService = ref.watch(buildingServiceProvider);
  return buildingService.getActiveUpgrade();
});

/// Riverpod provider for upgrade time remaining
final upgradeTimeRemainingProvider = Provider<Duration?>((ref) {
  final buildingService = ref.watch(buildingServiceProvider);
  return buildingService.getUpgradeTimeRemaining();
});

/// Combined building state provider
final buildingStateProvider = Provider<AsyncValue<({
  bool hasActiveUpgrade,
  String? buildingName,
  int? currentLevel,
  int? newLevel,
  String? timeRemaining,
  bool canAffordNextUpgrade,
})>>((ref) {
  final activeUpgrade = ref.watch(activeUpgradeProvider);
  final timeRemaining = ref.watch(upgradeTimeRemainingProvider);
  final buildingService = ref.watch(buildingServiceProvider);
  
  final hasActiveUpgrade = activeUpgrade != null;
  final buildingName = activeUpgrade?['buildingName'];
  final currentLevel = activeUpgrade?['currentLevel'];
  final newLevel = activeUpgrade?['newLevel'];
  
  // Format time remaining
  String? formattedTime;
  if (timeRemaining != null) {
    formattedTime = buildingService.formatTimeRemaining(timeRemaining);
  }
  
  // Check if user can afford next upgrade (for mine building)
  final canAffordMineUpgrade = buildingService.canAffordUpgrade('mine', 1);
  
  return AsyncData((
    hasActiveUpgrade: hasActiveUpgrade,
    buildingName: buildingName,
    currentLevel: currentLevel,
    newLevel: newLevel,
    timeRemaining: formattedTime,
    canAffordNextUpgrade: canAffordMineUpgrade,
  ));
});