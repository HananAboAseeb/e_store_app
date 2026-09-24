import 'package:equatable/equatable.dart';

class ContactInfoEntity extends Equatable {
  final String id;
  final String phone;
  final String email;

  const ContactInfoEntity({
    required this.id,
    required this.phone,
    required this.email,
  });

  ContactInfoEntity copyWith({
    String? id,
    String? phone,
    String? email,
  }) {
    return ContactInfoEntity(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, phone, email];
}
