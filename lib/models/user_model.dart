import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String username,
    @Default(1000) int titanium,
    @Default(500) int quantumFuel,
    @Default(50) int credits,
    required DateTime lastLogin,
    @Default([]) List<String> ownedItems,
    @Default(100) int health,
    @Default(1) int level,
    @Default(0) int experience,
    @Default(false) bool isBot,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}