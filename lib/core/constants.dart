class GameConstants {
  // Resource constants
  static const int initialTitanium = 1000;
  static const int initialQuantumFuel = 500;
  static const int initialCredits = 50;
  static const int initialHealth = 100;
  
  // Building costs
  static Map<String, Map<String, int>> buildingCosts = {
    'mine': {
      'titanium': 100,
      'quantumFuel': 50,
      'timeSeconds': 300, // 5 minutes
    },
    'refinery': {
      'titanium': 150,
      'quantumFuel': 75,
      'timeSeconds': 600, // 10 minutes
    },
    'command_center': {
      'titanium': 300,
      'quantumFuel': 150,
      'timeSeconds': 1800, // 30 minutes
    },
    'research_lab': {
      'titanium': 500,
      'quantumFuel': 250,
      'timeSeconds': 3600, // 1 hour
    },
    'shipyard': {
      'titanium': 1000,
      'quantumFuel': 500,
      'timeSeconds': 7200, // 2 hours
    },
  };
  
  // Production rates per level
  static Map<String, int> productionRates = {
    'mine': 10, // titanium per hour
    'refinery': 5, // quantum fuel per hour
  };
  
  // Exploration constants
  static const int explorationEnergyCost = 10;
  static const int maxEnergy = 100;
  static const int energyRegenPerHour = 5;
  
  // Combat constants
  static const int baseAttackPower = 10;
  static const int baseDefensePower = 5;
  
  // Ad rewards
  static const int adRewardCredits = 25;
  static const int adRewardEnergy = 20;
  
  // Game balance
  static const int levelUpExperience = 100;
  static const double experienceMultiplier = 1.5;
}

class FirebaseConstants {
  static const String usersCollection = 'users';
  static const String basesCollection = 'bases';
  static const String explorationsCollection = 'explorations';
  static const String inventoryCollection = 'inventory';
  static const String combatLogsCollection = 'combat_logs';
  static const String leaderboardCollection = 'leaderboard';
}

class AssetPaths {
  // Resource icons
  static const String titaniumIcon = 'assets/images/resources/titanium.png';
  static const String quantumFuelIcon = 'assets/images/resources/quantum_fuel.png';
  static const String creditIcon = 'assets/images/resources/credit.png';
  static const String healthIcon = 'assets/images/resources/health.png';
  static const String energyIcon = 'assets/images/resources/energy.png';
  
  // Building icons
  static const String mineIcon = 'assets/images/buildings/mine.png';
  static const String refineryIcon = 'assets/images/buildings/refinery.png';
  static const String commandCenterIcon = 'assets/images/buildings/command_center.png';
  static const String researchLabIcon = 'assets/images/buildings/research_lab.png';
  static const String shipyardIcon = 'assets/images/buildings/shipyard.png';
  
  // Planet images
  static const String planetAlpha = 'assets/images/planets/alpha.png';
  static const String planetBeta = 'assets/images/planets/beta.png';
  static const String planetGamma = 'assets/images/planets/gamma.png';
  
  // Sector images
  static const String sectorUnknown = 'assets/images/sectors/unknown.png';
  static const String sectorNebula = 'assets/images/sectors/nebula.png';
  static const String sectorAsteroid = 'assets/images/sectors/asteroid.png';
  static const String sectorDerelict = 'assets/images/sectors/derelict.png';

  /// Tam ekran sekme arka planları; üretim özeti `docs/OPENCLAW_HANDOFF.md`.
  static const String heroHubPrimary = 'assets/images/1.1.png';
  static const String heroHubVariantA = 'assets/images/1.2.png';
  static const String heroHubVariantB = 'assets/images/1.3.png';
  static const String heroInventory = 'assets/images/2.1.png';
  static const String heroExploration = 'assets/images/2.2.png';
  static const String heroCombat = 'assets/images/2.3.png';
  static const String heroMeta = 'assets/images/3.png';

  /// Küçük UI dilimleri (menü, düğme görselleri).
  static const String uiButtonNormal = 'assets/images/ui/button_normal.png';
  static const String uiButtonPressed = 'assets/images/ui/button_pressed.png';
  static const String uiIconMenu = 'assets/images/ui/icon_menu.png';
  static const String uiIconBack = 'assets/images/ui/icon_back.png';
}