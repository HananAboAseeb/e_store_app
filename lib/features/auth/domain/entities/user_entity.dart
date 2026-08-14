import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? phoneNumber;
  final String? fullName;
  final String? avatarUrl;
  final String? token;
  final bool isVerified;

  const UserEntity({
    required this.id,
    required this.email,
    this.phoneNumber,
    this.fullName,
    this.avatarUrl,
    this.token,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        fullName,
        avatarUrl,
        token,
        isVerified,
      ];
}
