import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/shipping_address_entity.dart';
import '../../domain/usecases/get_shipping_address_usecase.dart';
import '../../domain/usecases/update_shipping_address_usecase.dart';
import 'shipping_settings_state.dart';

class ShippingSettingsCubit extends Cubit<ShippingSettingsState> {
  final GetShippingAddressUseCase getShippingAddressUseCase;
  final UpdateShippingAddressUseCase updateShippingAddressUseCase;

  ShippingSettingsCubit({
    required this.getShippingAddressUseCase,
    required this.updateShippingAddressUseCase,
  }) : super(const ShippingSettingsState());

  Future<void> loadAddress() async {
    emit(state.copyWith(status: ShippingSettingsStatus.loading));
    final result = await getShippingAddressUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: ShippingSettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (address) => emit(state.copyWith(
        status: ShippingSettingsStatus.loaded,
        address: address,
      )),
    );
  }

  void toggleEditMode() {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void updateCountry(String country) {
    if (state.address != null) {
      emit(state.copyWith(
        address: state.address!.copyWith(country: country),
      ));
    }
  }

  Future<void> saveAddress(ShippingAddressEntity updated) async {
    emit(state.copyWith(status: ShippingSettingsStatus.saving));
    final result = await updateShippingAddressUseCase(updated);
    result.fold(
      (failure) => emit(state.copyWith(
        status: ShippingSettingsStatus.failure,
        errorMessage: failure.message,
      )),
      (address) => emit(state.copyWith(
        status: ShippingSettingsStatus.saveSuccess,
        address: address,
        isEditing: false,
      )),
    );
  }
}
