import '../../domain/entities/user_account_entity.dart';

class UserAccountModel extends UserAccountEntity {
  const UserAccountModel({
    required super.id,
    required super.username,
    required super.email,
    required super.passwordMasked,
    required super.avatarUrl,
  });

  factory UserAccountModel.fromEntity(UserAccountEntity entity) {
    return UserAccountModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      passwordMasked: entity.passwordMasked,
      avatarUrl: entity.avatarUrl,
    );
  }

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      passwordMasked: json['passwordMasked'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'passwordMasked': passwordMasked,
      'avatarUrl': avatarUrl,
    };
  }
}
