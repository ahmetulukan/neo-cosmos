import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_model.freezed.dart';
part 'base_model.g.dart';

@freezed
class BuildingUpgrade with _$BuildingUpgrade {
  factory BuildingUpgrade({
    required String buildingId,
    required int targetLevel,
    required DateTime completionTime,
    @Default(false) bool isCompleted,
  }) = _BuildingUpgrade;

  factory BuildingUpgrade.fromJson(Map<String, dynamic> json) =>
      _$BuildingUpgradeFromJson(json);
}

@freezed
class BaseModel with _$BaseModel {
  factory BaseModel({
    required String userId,
    @Default({
      'mine': 1,
      'refinery': 1,
      'command_center': 1,
      'research_lab': 1,
      'shipyard': 1,
    }) Map<String, int> buildingLevels,
    @Default([]) List<BuildingUpgrade> activeUpgrades,
    required DateTime lastUpdated,
    @Default('planet_alpha') String planetName,
    @Default('assets/images/planets/alpha.png') String planetImage,
  }) = _BaseModel;

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
}