import '../../domain/entities/contact_info_entity.dart';

class ContactInfoModel extends ContactInfoEntity {
  const ContactInfoModel({
    required super.id,
    required super.phone,
    required super.email,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      id: json['id'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'email': email,
    };
  }

  factory ContactInfoModel.fromEntity(ContactInfoEntity entity) {
    return ContactInfoModel(
      id: entity.id,
      phone: entity.phone,
      email: entity.email,
    );
  }

  ContactInfoEntity toEntity() => this;
}
