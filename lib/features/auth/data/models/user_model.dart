import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return const UserModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
