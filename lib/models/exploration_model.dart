import 'package:freezed_annotation/freezed_annotation.dart';

part 'exploration_model.freezed.dart';
part 'exploration_model.g.dart';

enum ExplorationOutcome {
  success,
  failure,
  neutral,
  combat,
  discovery,
}

@freezed
class ExplorationResult with _$ExplorationResult {
  factory ExplorationResult({
    required String story,
    required ExplorationOutcome outcome,
    String? itemReward,
    int? titaniumReward,
    int? quantumFuelReward,
    int? creditsReward,
    int? damageTaken,
    int? experienceGained,
    required DateTime timestamp,
    @Default('unknown_sector') String sectorName,
    @Default('assets/images/sectors/unknown.png') String sectorImage,
  }) = _ExplorationResult;

  factory ExplorationResult.fromJson(Map<String, dynamic> json) =>
      _$ExplorationResultFromJson(json);
}

@freezed
class ExplorationRequest with _$ExplorationRequest {
  factory ExplorationRequest({
    required String userId,
    required String action,
    required int energyCost,
    required DateTime timestamp,
    Map<String, dynamic>? context,
  }) = _ExplorationRequest;

  factory ExplorationRequest.fromJson(Map<String, dynamic> json) =>
      _$ExplorationRequestFromJson(json);
}