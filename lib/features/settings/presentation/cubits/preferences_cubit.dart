import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/entities/size_standard_entity.dart';
import '../../domain/usecases/get_preferences_usecase.dart';
import '../../domain/usecases/update_preference_usecase.dart';
import 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final GetPreferencesUseCase getPreferencesUseCase;
  final UpdatePreferenceUseCase updatePreferenceUseCase;

  PreferencesCubit({
    required this.getPreferencesUseCase,
    required this.updatePreferenceUseCase,
  }) : super(const PreferencesState());

  Future<void> loadPreferences({bool forceRefresh = false}) async {
    if (state.status == PreferencesStatus.loaded && !forceRefresh) {
      return;
    }
    emit(state.copyWith(status: PreferencesStatus.loading));
    final result = await getPreferencesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        status: PreferencesStatus.failure,
        errorMessage: failure.message,
      )),
      (bundle) {
        final currentSelectedCountry = state.selectedCountry;
        final selectedCountry = currentSelectedCountry != null
            ? bundle.countries.firstWhere(
                (c) => c.id == currentSelectedCountry.id,
                orElse: () => currentSelectedCountry,
              )
            : bundle.countries.firstWhere(
                (c) => c.isSelected,
                orElse: () => bundle.countries.isNotEmpty
                    ? bundle.countries.first
                    : const CountryEntity(
                        id: 'c_ye', name: 'Yemen (اليمن)', code: 'YE'),
              );
        final currentSelectedLanguage = state.selectedLanguage;
        final selectedLanguage = currentSelectedLanguage != null
            ? bundle.languages.firstWhere(
                (l) => l.id == currentSelectedLanguage.id,
                orElse: () => currentSelectedLanguage,
              )
            : bundle.languages.firstWhere(
                (l) => l.isSelected,
                orElse: () => bundle.languages.isNotEmpty
                    ? bundle.languages.first
                    : const LanguageEntity(
                        id: 'en',
                        name: 'English',
                        nativeName: 'English',
                        localeCode: 'en',
                      ),
              );
        final currentSelectedCurrency = state.selectedCurrency;
        final selectedCurrency = currentSelectedCurrency != null
            ? bundle.currencies.firstWhere(
                (c) => c.id == currentSelectedCurrency.id,
                orElse: () => currentSelectedCurrency,
              )
            : bundle.currencies.firstWhere(
                (c) => c.isSelected,
                orElse: () => bundle.currencies.isNotEmpty
                    ? bundle.currencies.first
                    : const CurrencyEntity(
                        id: 'usd',
                        code: 'USD',
                        symbol: '\$',
                        label: '\$ USD',
                      ),
              );
        final currentSelectedSize = state.selectedSize;
        final selectedSize = currentSelectedSize != null
            ? bundle.sizes.firstWhere(
                (s) => s.id == currentSelectedSize.id,
                orElse: () => currentSelectedSize,
              )
            : bundle.sizes.firstWhere(
                (s) => s.isSelected,
                orElse: () => bundle.sizes.isNotEmpty
                    ? bundle.sizes.first
                    : const SizeStandardEntity(id: 'us', label: 'US'),
              );

        emit(state.copyWith(
          status: PreferencesStatus.loaded,
          countries: bundle.countries,
          selectedCountry: selectedCountry,
          languages: bundle.languages,
          selectedLanguage: selectedLanguage,
          currencies: bundle.currencies,
          selectedCurrency: selectedCurrency,
          sizes: bundle.sizes,
          selectedSize: selectedSize,
        ));
      },
    );
  }

  void searchCountry(String query) {
    emit(state.copyWith(countrySearchQuery: query));
  }

  void selectCountry(CountryEntity country) {
    final updated = state.countries.map((c) {
      return c.copyWith(isSelected: c.id == country.id);
    }).toList();
    emit(state.copyWith(
      countries: updated,
      selectedCountry: country.copyWith(isSelected: true),
    ));
    updatePreferenceUseCase(UpdatePreferenceParams(
      type: PreferenceType.country,
      value: country.name,
    ));
  }

  void selectLanguage(LanguageEntity language) {
    final updated = state.languages.map((l) {
      return l.copyWith(isSelected: l.id == language.id);
    }).toList();
    emit(state.copyWith(
      languages: updated,
      selectedLanguage: language.copyWith(isSelected: true),
    ));
    updatePreferenceUseCase(UpdatePreferenceParams(
      type: PreferenceType.language,
      value: language.localeCode,
    ));
  }

  void selectCurrency(CurrencyEntity currency) {
    final updated = state.currencies.map((c) {
      return c.copyWith(isSelected: c.id == currency.id);
    }).toList();
    emit(state.copyWith(
      currencies: updated,
      selectedCurrency: currency.copyWith(isSelected: true),
    ));
    updatePreferenceUseCase(UpdatePreferenceParams(
      type: PreferenceType.currency,
      value: currency.code,
    ));
  }

  void selectSize(SizeStandardEntity size) {
    final updated = state.sizes.map((s) {
      return s.copyWith(isSelected: s.id == size.id);
    }).toList();
    emit(state.copyWith(
      sizes: updated,
      selectedSize: size.copyWith(isSelected: true),
    ));
    updatePreferenceUseCase(UpdatePreferenceParams(
      type: PreferenceType.size,
      value: size.label,
    ));
  }
}
