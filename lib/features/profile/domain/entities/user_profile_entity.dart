import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String name;
  final String greeting;
  final String avatarUrl;

  const UserProfileEntity({
    required this.id,
    required this.name,
    required this.greeting,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, greeting, avatarUrl];
}
