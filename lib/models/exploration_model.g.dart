// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exploration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExplorationResultImpl _$$ExplorationResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplorationResultImpl(
      story: json['story'] as String,
      outcome: $enumDecode(_$ExplorationOutcomeEnumMap, json['outcome']),
      itemReward: json['itemReward'] as String?,
      titaniumReward: (json['titaniumReward'] as num?)?.toInt(),
      quantumFuelReward: (json['quantumFuelReward'] as num?)?.toInt(),
      creditsReward: (json['creditsReward'] as num?)?.toInt(),
      damageTaken: (json['damageTaken'] as num?)?.toInt(),
      experienceGained: (json['experienceGained'] as num?)?.toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      sectorName: json['sectorName'] as String? ?? 'unknown_sector',
      sectorImage:
          json['sectorImage'] as String? ?? 'assets/images/sectors/unknown.png',
    );

Map<String, dynamic> _$$ExplorationResultImplToJson(
        _$ExplorationResultImpl instance) =>
    <String, dynamic>{
      'story': instance.story,
      'outcome': _$ExplorationOutcomeEnumMap[instance.outcome]!,
      'itemReward': instance.itemReward,
      'titaniumReward': instance.titaniumReward,
      'quantumFuelReward': instance.quantumFuelReward,
      'creditsReward': instance.creditsReward,
      'damageTaken': instance.damageTaken,
      'experienceGained': instance.experienceGained,
      'timestamp': instance.timestamp.toIso8601String(),
      'sectorName': instance.sectorName,
      'sectorImage': instance.sectorImage,
    };

const _$ExplorationOutcomeEnumMap = {
  ExplorationOutcome.success: 'success',
  ExplorationOutcome.failure: 'failure',
  ExplorationOutcome.neutral: 'neutral',
  ExplorationOutcome.combat: 'combat',
  ExplorationOutcome.discovery: 'discovery',
};

_$ExplorationRequestImpl _$$ExplorationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ExplorationRequestImpl(
      userId: json['userId'] as String,
      action: json['action'] as String,
      energyCost: (json['energyCost'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      context: json['context'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ExplorationRequestImplToJson(
        _$ExplorationRequestImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'action': instance.action,
      'energyCost': instance.energyCost,
      'timestamp': instance.timestamp.toIso8601String(),
      'context': instance.context,
    };
