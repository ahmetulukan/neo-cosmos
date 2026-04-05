// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BuildingUpgrade _$BuildingUpgradeFromJson(Map<String, dynamic> json) {
  return _BuildingUpgrade.fromJson(json);
}

/// @nodoc
mixin _$BuildingUpgrade {
  String get buildingId => throw _privateConstructorUsedError;
  int get targetLevel => throw _privateConstructorUsedError;
  DateTime get completionTime => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this BuildingUpgrade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BuildingUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuildingUpgradeCopyWith<BuildingUpgrade> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildingUpgradeCopyWith<$Res> {
  factory $BuildingUpgradeCopyWith(
          BuildingUpgrade value, $Res Function(BuildingUpgrade) then) =
      _$BuildingUpgradeCopyWithImpl<$Res, BuildingUpgrade>;
  @useResult
  $Res call(
      {String buildingId,
      int targetLevel,
      DateTime completionTime,
      bool isCompleted});
}

/// @nodoc
class _$BuildingUpgradeCopyWithImpl<$Res, $Val extends BuildingUpgrade>
    implements $BuildingUpgradeCopyWith<$Res> {
  _$BuildingUpgradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuildingUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildingId = null,
    Object? targetLevel = null,
    Object? completionTime = null,
    Object? isCompleted = null,
  }) {
    return _then(_value.copyWith(
      buildingId: null == buildingId
          ? _value.buildingId
          : buildingId // ignore: cast_nullable_to_non_nullable
              as String,
      targetLevel: null == targetLevel
          ? _value.targetLevel
          : targetLevel // ignore: cast_nullable_to_non_nullable
              as int,
      completionTime: null == completionTime
          ? _value.completionTime
          : completionTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuildingUpgradeImplCopyWith<$Res>
    implements $BuildingUpgradeCopyWith<$Res> {
  factory _$$BuildingUpgradeImplCopyWith(_$BuildingUpgradeImpl value,
          $Res Function(_$BuildingUpgradeImpl) then) =
      __$$BuildingUpgradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String buildingId,
      int targetLevel,
      DateTime completionTime,
      bool isCompleted});
}

/// @nodoc
class __$$BuildingUpgradeImplCopyWithImpl<$Res>
    extends _$BuildingUpgradeCopyWithImpl<$Res, _$BuildingUpgradeImpl>
    implements _$$BuildingUpgradeImplCopyWith<$Res> {
  __$$BuildingUpgradeImplCopyWithImpl(
      _$BuildingUpgradeImpl _value, $Res Function(_$BuildingUpgradeImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuildingUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buildingId = null,
    Object? targetLevel = null,
    Object? completionTime = null,
    Object? isCompleted = null,
  }) {
    return _then(_$BuildingUpgradeImpl(
      buildingId: null == buildingId
          ? _value.buildingId
          : buildingId // ignore: cast_nullable_to_non_nullable
              as String,
      targetLevel: null == targetLevel
          ? _value.targetLevel
          : targetLevel // ignore: cast_nullable_to_non_nullable
              as int,
      completionTime: null == completionTime
          ? _value.completionTime
          : completionTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuildingUpgradeImpl implements _BuildingUpgrade {
  _$BuildingUpgradeImpl(
      {required this.buildingId,
      required this.targetLevel,
      required this.completionTime,
      this.isCompleted = false});

  factory _$BuildingUpgradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuildingUpgradeImplFromJson(json);

  @override
  final String buildingId;
  @override
  final int targetLevel;
  @override
  final DateTime completionTime;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'BuildingUpgrade(buildingId: $buildingId, targetLevel: $targetLevel, completionTime: $completionTime, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildingUpgradeImpl &&
            (identical(other.buildingId, buildingId) ||
                other.buildingId == buildingId) &&
            (identical(other.targetLevel, targetLevel) ||
                other.targetLevel == targetLevel) &&
            (identical(other.completionTime, completionTime) ||
                other.completionTime == completionTime) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, buildingId, targetLevel, completionTime, isCompleted);

  /// Create a copy of BuildingUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildingUpgradeImplCopyWith<_$BuildingUpgradeImpl> get copyWith =>
      __$$BuildingUpgradeImplCopyWithImpl<_$BuildingUpgradeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuildingUpgradeImplToJson(
      this,
    );
  }
}

abstract class _BuildingUpgrade implements BuildingUpgrade {
  factory _BuildingUpgrade(
      {required final String buildingId,
      required final int targetLevel,
      required final DateTime completionTime,
      final bool isCompleted}) = _$BuildingUpgradeImpl;

  factory _BuildingUpgrade.fromJson(Map<String, dynamic> json) =
      _$BuildingUpgradeImpl.fromJson;

  @override
  String get buildingId;
  @override
  int get targetLevel;
  @override
  DateTime get completionTime;
  @override
  bool get isCompleted;

  /// Create a copy of BuildingUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuildingUpgradeImplCopyWith<_$BuildingUpgradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return _BaseModel.fromJson(json);
}

/// @nodoc
mixin _$BaseModel {
  String get userId => throw _privateConstructorUsedError;
  Map<String, int> get buildingLevels => throw _privateConstructorUsedError;
  List<BuildingUpgrade> get activeUpgrades =>
      throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  String get planetName => throw _privateConstructorUsedError;
  String get planetImage => throw _privateConstructorUsedError;

  /// Serializes this BaseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseModelCopyWith<BaseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseModelCopyWith<$Res> {
  factory $BaseModelCopyWith(BaseModel value, $Res Function(BaseModel) then) =
      _$BaseModelCopyWithImpl<$Res, BaseModel>;
  @useResult
  $Res call(
      {String userId,
      Map<String, int> buildingLevels,
      List<BuildingUpgrade> activeUpgrades,
      DateTime lastUpdated,
      String planetName,
      String planetImage});
}

/// @nodoc
class _$BaseModelCopyWithImpl<$Res, $Val extends BaseModel>
    implements $BaseModelCopyWith<$Res> {
  _$BaseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? buildingLevels = null,
    Object? activeUpgrades = null,
    Object? lastUpdated = null,
    Object? planetName = null,
    Object? planetImage = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      buildingLevels: null == buildingLevels
          ? _value.buildingLevels
          : buildingLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      activeUpgrades: null == activeUpgrades
          ? _value.activeUpgrades
          : activeUpgrades // ignore: cast_nullable_to_non_nullable
              as List<BuildingUpgrade>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      planetName: null == planetName
          ? _value.planetName
          : planetName // ignore: cast_nullable_to_non_nullable
              as String,
      planetImage: null == planetImage
          ? _value.planetImage
          : planetImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseModelImplCopyWith<$Res>
    implements $BaseModelCopyWith<$Res> {
  factory _$$BaseModelImplCopyWith(
          _$BaseModelImpl value, $Res Function(_$BaseModelImpl) then) =
      __$$BaseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      Map<String, int> buildingLevels,
      List<BuildingUpgrade> activeUpgrades,
      DateTime lastUpdated,
      String planetName,
      String planetImage});
}

/// @nodoc
class __$$BaseModelImplCopyWithImpl<$Res>
    extends _$BaseModelCopyWithImpl<$Res, _$BaseModelImpl>
    implements _$$BaseModelImplCopyWith<$Res> {
  __$$BaseModelImplCopyWithImpl(
      _$BaseModelImpl _value, $Res Function(_$BaseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BaseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? buildingLevels = null,
    Object? activeUpgrades = null,
    Object? lastUpdated = null,
    Object? planetName = null,
    Object? planetImage = null,
  }) {
    return _then(_$BaseModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      buildingLevels: null == buildingLevels
          ? _value._buildingLevels
          : buildingLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      activeUpgrades: null == activeUpgrades
          ? _value._activeUpgrades
          : activeUpgrades // ignore: cast_nullable_to_non_nullable
              as List<BuildingUpgrade>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      planetName: null == planetName
          ? _value.planetName
          : planetName // ignore: cast_nullable_to_non_nullable
              as String,
      planetImage: null == planetImage
          ? _value.planetImage
          : planetImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseModelImpl implements _BaseModel {
  _$BaseModelImpl(
      {required this.userId,
      final Map<String, int> buildingLevels = const {
        'mine': 1,
        'refinery': 1,
        'command_center': 1,
        'research_lab': 1,
        'shipyard': 1
      },
      final List<BuildingUpgrade> activeUpgrades = const [],
      required this.lastUpdated,
      this.planetName = 'planet_alpha',
      this.planetImage = 'assets/images/planets/alpha.png'})
      : _buildingLevels = buildingLevels,
        _activeUpgrades = activeUpgrades;

  factory _$BaseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseModelImplFromJson(json);

  @override
  final String userId;
  final Map<String, int> _buildingLevels;
  @override
  @JsonKey()
  Map<String, int> get buildingLevels {
    if (_buildingLevels is EqualUnmodifiableMapView) return _buildingLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_buildingLevels);
  }

  final List<BuildingUpgrade> _activeUpgrades;
  @override
  @JsonKey()
  List<BuildingUpgrade> get activeUpgrades {
    if (_activeUpgrades is EqualUnmodifiableListView) return _activeUpgrades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeUpgrades);
  }

  @override
  final DateTime lastUpdated;
  @override
  @JsonKey()
  final String planetName;
  @override
  @JsonKey()
  final String planetImage;

  @override
  String toString() {
    return 'BaseModel(userId: $userId, buildingLevels: $buildingLevels, activeUpgrades: $activeUpgrades, lastUpdated: $lastUpdated, planetName: $planetName, planetImage: $planetImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._buildingLevels, _buildingLevels) &&
            const DeepCollectionEquality()
                .equals(other._activeUpgrades, _activeUpgrades) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.planetName, planetName) ||
                other.planetName == planetName) &&
            (identical(other.planetImage, planetImage) ||
                other.planetImage == planetImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      const DeepCollectionEquality().hash(_buildingLevels),
      const DeepCollectionEquality().hash(_activeUpgrades),
      lastUpdated,
      planetName,
      planetImage);

  /// Create a copy of BaseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseModelImplCopyWith<_$BaseModelImpl> get copyWith =>
      __$$BaseModelImplCopyWithImpl<_$BaseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseModelImplToJson(
      this,
    );
  }
}

abstract class _BaseModel implements BaseModel {
  factory _BaseModel(
      {required final String userId,
      final Map<String, int> buildingLevels,
      final List<BuildingUpgrade> activeUpgrades,
      required final DateTime lastUpdated,
      final String planetName,
      final String planetImage}) = _$BaseModelImpl;

  factory _BaseModel.fromJson(Map<String, dynamic> json) =
      _$BaseModelImpl.fromJson;

  @override
  String get userId;
  @override
  Map<String, int> get buildingLevels;
  @override
  List<BuildingUpgrade> get activeUpgrades;
  @override
  DateTime get lastUpdated;
  @override
  String get planetName;
  @override
  String get planetImage;

  /// Create a copy of BaseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseModelImplCopyWith<_$BaseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
