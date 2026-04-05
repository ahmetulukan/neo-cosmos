// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuildingUpgradeImpl _$$BuildingUpgradeImplFromJson(
        Map<String, dynamic> json) =>
    _$BuildingUpgradeImpl(
      buildingId: json['buildingId'] as String,
      targetLevel: (json['targetLevel'] as num).toInt(),
      completionTime: DateTime.parse(json['completionTime'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$BuildingUpgradeImplToJson(
        _$BuildingUpgradeImpl instance) =>
    <String, dynamic>{
      'buildingId': instance.buildingId,
      'targetLevel': instance.targetLevel,
      'completionTime': instance.completionTime.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };

_$BaseModelImpl _$$BaseModelImplFromJson(Map<String, dynamic> json) =>
    _$BaseModelImpl(
      userId: json['userId'] as String,
      buildingLevels: (json['buildingLevels'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {
            'mine': 1,
            'refinery': 1,
            'command_center': 1,
            'research_lab': 1,
            'shipyard': 1
          },
      activeUpgrades: (json['activeUpgrades'] as List<dynamic>?)
              ?.map((e) => BuildingUpgrade.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      planetName: json['planetName'] as String? ?? 'planet_alpha',
      planetImage:
          json['planetImage'] as String? ?? 'assets/images/planets/alpha.png',
    );

Map<String, dynamic> _$$BaseModelImplToJson(_$BaseModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'buildingLevels': instance.buildingLevels,
      'activeUpgrades': instance.activeUpgrades,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'planetName': instance.planetName,
      'planetImage': instance.planetImage,
    };
