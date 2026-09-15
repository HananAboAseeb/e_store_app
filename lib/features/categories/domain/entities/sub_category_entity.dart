import 'package:equatable/equatable.dart';

class SubCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String parentGroupId;

  const SubCategoryEntity({
    required this.id,
    required this.name,
    required this.parentGroupId,
  });

  @override
  List<Object?> get props => [id, name, parentGroupId];
}
