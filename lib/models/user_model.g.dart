// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      titanium: (json['titanium'] as num?)?.toInt() ?? 1000,
      quantumFuel: (json['quantumFuel'] as num?)?.toInt() ?? 500,
      credits: (json['credits'] as num?)?.toInt() ?? 50,
      lastLogin: DateTime.parse(json['lastLogin'] as String),
      ownedItems: (json['ownedItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      health: (json['health'] as num?)?.toInt() ?? 100,
      level: (json['level'] as num?)?.toInt() ?? 1,
      experience: (json['experience'] as num?)?.toInt() ?? 0,
      isBot: json['isBot'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'titanium': instance.titanium,
      'quantumFuel': instance.quantumFuel,
      'credits': instance.credits,
      'lastLogin': instance.lastLogin.toIso8601String(),
      'ownedItems': instance.ownedItems,
      'health': instance.health,
      'level': instance.level,
      'experience': instance.experience,
      'isBot': instance.isBot,
    };
