import 'package:equatable/equatable.dart';

class UserAccountEntity extends Equatable {
  final String id;
  final String username;
  final String email;
  final String passwordMasked;
  final String avatarUrl;

  const UserAccountEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordMasked,
    required this.avatarUrl,
  });

  UserAccountEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? passwordMasked,
    String? avatarUrl,
  }) {
    return UserAccountEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordMasked: passwordMasked ?? this.passwordMasked,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, username, email, passwordMasked, avatarUrl];
}
