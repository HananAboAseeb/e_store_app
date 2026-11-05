import 'package:equatable/equatable.dart';

import '../../domain/entities/shipping_address_entity.dart';

enum ShippingSettingsStatus {
  initial,
  loading,
  loaded,
  saving,
  saveSuccess,
  failure
}

class ShippingSettingsState extends Equatable {
  final ShippingSettingsStatus status;
  final ShippingAddressEntity? address;
  final bool isEditing;
  final String? errorMessage;

  const ShippingSettingsState({
    this.status = ShippingSettingsStatus.initial,
    this.address,
    this.isEditing = false,
    this.errorMessage,
  });

  ShippingSettingsState copyWith({
    ShippingSettingsStatus? status,
    ShippingAddressEntity? address,
    bool? isEditing,
    String? errorMessage,
  }) {
    return ShippingSettingsState(
      status: status ?? this.status,
      address: address ?? this.address,
      isEditing: isEditing ?? this.isEditing,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, address, isEditing, errorMessage];
}
