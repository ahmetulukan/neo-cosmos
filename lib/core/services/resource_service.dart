import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../models/user_model.dart';
import '../constants.dart';

/// Resource management service for Neo Cosmos
class ResourceService {
  final Box<UserModel> _userBox;
  Timer? _resourceTimer;
  
  ResourceService(this._userBox);
  
  /// Get current user data
  UserModel? get currentUser {
    return _userBox.get('current_user');
  }
  
  /// Initialize resource production system
  void initializeResourceProduction() {
    // Start resource production timer (every 10 seconds for testing)
    _resourceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _produceResources();
    });
    
    print('✅ Resource production system initialized');
  }
  
  /// Produce resources based on building levels
  void _produceResources() {
    final user = currentUser;
    if (user == null) return;
    
    // Calculate production based on building levels
    final titaniumProduction = _calculateTitaniumProduction(user);
    final quantumFuelProduction = _calculateQuantumFuelProduction(user);
    
    // Update user resources
    final updatedUser = user.copyWith(
      titanium: user.titanium + titaniumProduction,
      quantumFuel: user.quantumFuel + quantumFuelProduction,
    );
    
    // Save to Hive
    _userBox.put('current_user', updatedUser);
    
    print('📦 Resources produced: +$titaniumProduction Titanium, +$quantumFuelProduction Quantum Fuel');
  }
  
  /// Calculate titanium production based on mine level
  int _calculateTitaniumProduction(UserModel user) {
    // Base production + mine level multiplier
    const baseProduction = 1;
    const mineMultiplier = 2; // Each mine level adds 2 titanium/second
    
    // In real implementation, this would use building levels from Firestore
    // For now, using placeholder
    return baseProduction * mineMultiplier;
  }
  
  /// Calculate quantum fuel production based on refinery level
  int _calculateQuantumFuelProduction(UserModel user) {
    // Base production + refinery level multiplier
    const baseProduction = 1;
    const refineryMultiplier = 1; // Each refinery level adds 1 fuel/second
    
    return baseProduction * refineryMultiplier;
  }
  
  /// Check if user has enough resources for an action
  bool hasEnoughResources({
    required int titaniumCost,
    required int quantumFuelCost,
    required int creditCost,
  }) {
    final user = currentUser;
    if (user == null) return false;
    
    return user.titanium >= titaniumCost &&
           user.quantumFuel >= quantumFuelCost &&
           user.credits >= creditCost;
  }
  
  /// Spend resources
  bool spendResources({
    required int titaniumCost,
    required int quantumFuelCost,
    required int creditCost,
  }) {
    if (!hasEnoughResources(
      titaniumCost: titaniumCost,
      quantumFuelCost: quantumFuelCost,
      creditCost: creditCost,
    )) {
      return false;
    }
    
    final user = currentUser;
    if (user == null) return false;
    
    final updatedUser = user.copyWith(
      titanium: user.titanium - titaniumCost,
      quantumFuel: user.quantumFuel - quantumFuelCost,
      credits: user.credits - creditCost,
    );
    
    _userBox.put('current_user', updatedUser);
    return true;
  }
  
  /// Add resources (for rewards, purchases, etc.)
  void addResources({
    int titanium = 0,
    int quantumFuel = 0,
    int credits = 0,
  }) {
    final user = currentUser;
    if (user == null) return;
    
    final updatedUser = user.copyWith(
      titanium: user.titanium + titanium,
      quantumFuel: user.quantumFuel + quantumFuel,
      credits: user.credits + credits,
    );
    
    _userBox.put('current_user', updatedUser);
    
    print('🎁 Resources added: +$titanium Titanium, +$quantumFuel Quantum Fuel, +$credits Credits');
  }
  
  /// Get resource production rates
  Map<String, int> getProductionRates() {
    final user = currentUser;
    if (user == null) return {'titanium': 0, 'quantumFuel': 0};
    
    return {
      'titanium': _calculateTitaniumProduction(user),
      'quantumFuel': _calculateQuantumFuelProduction(user),
    };
  }
  
  /// Clean up timers
  void dispose() {
    _resourceTimer?.cancel();
    _resourceTimer = null;
  }
}

/// Riverpod provider for ResourceService
final resourceServiceProvider = Provider<ResourceService>((ref) {
  final userBox = Hive.box<UserModel>('user_data');
  return ResourceService(userBox);
});

/// Riverpod provider for current resources
final resourcesProvider = Provider<({int titanium, int quantumFuel, int credits})>((ref) {
  final userBox = Hive.box<UserModel>('user_data');
  final user = userBox.get('current_user');
  
  if (user == null) {
    // Return initial resources if no user exists
    return (
      titanium: GameConstants.initialTitanium,
      quantumFuel: GameConstants.initialQuantumFuel,
      credits: GameConstants.initialCredits,
    );
  }
  
  return (
    titanium: user.titanium,
    quantumFuel: user.quantumFuel,
    credits: user.credits,
  );
});

/// Riverpod provider for production rates
final productionRatesProvider = Provider<Map<String, int>>((ref) {
  final resourceService = ref.watch(resourceServiceProvider);
  return resourceService.getProductionRates();
});

/// Combined resource state provider
final combinedResourcesProvider = Provider<AsyncValue<({
  int titanium,
  int quantumFuel,
  int credits,
  Map<String, int> productionRates,
  bool canAffordUpgrade,
})>>((ref) {
  final resources = ref.watch(resourcesProvider);
  final productionRates = ref.watch(productionRatesProvider);
  
  // Check if user can afford a basic upgrade
  final canAffordUpgrade = resources.titanium >= 100 && resources.quantumFuel >= 50;
  
  return AsyncData((
    titanium: resources.titanium,
    quantumFuel: resources.quantumFuel,
    credits: resources.credits,
    productionRates: productionRates,
    canAffordUpgrade: canAffordUpgrade,
  ));
});