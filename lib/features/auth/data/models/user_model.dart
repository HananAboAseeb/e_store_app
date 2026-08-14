import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.phoneNumber,
    super.fullName,
    super.avatarUrl,
    super.token,
    super.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '1',
      email: json['email'] as String? ?? 'user@shopx.com',
      phoneNumber: json['phone_number'] as String? ?? '+1234567890',
      fullName: json['full_name'] as String? ?? 'ShopX User',
      avatarUrl: json['avatar_url'] as String?,
      token: json['token'] as String? ?? 'mock_jwt_token_shopx',
      isVerified: json['is_verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'token': token,
      'is_verified': isVerified,
    };
  }

  factory UserModel.mock({String? email, String? phone}) {
    return UserModel(
      id: 'mock_user_123',
      email: email ?? 'user@shopx.com',
      phoneNumber: phone ?? '+1234567890',
      fullName: 'John ShopX',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      token: 'mock_auth_token_xyz789',
      isVerified: true,
    );
  }
}
