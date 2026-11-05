import 'package:equatable/equatable.dart';

import '../../domain/entities/country_entity.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/language_entity.dart';
import '../../domain/entities/size_standard_entity.dart';

enum PreferencesStatus { initial, loading, loaded, failure }

class PreferencesState extends Equatable {
  final PreferencesStatus status;
  final List<CountryEntity> countries;
  final CountryEntity? selectedCountry;
  final String countrySearchQuery;
  final List<LanguageEntity> languages;
  final LanguageEntity? selectedLanguage;
  final List<CurrencyEntity> currencies;
  final CurrencyEntity? selectedCurrency;
  final List<SizeStandardEntity> sizes;
  final SizeStandardEntity? selectedSize;
  final String? errorMessage;

  const PreferencesState({
    this.status = PreferencesStatus.initial,
    this.countries = const [],
    this.selectedCountry,
    this.countrySearchQuery = '',
    this.languages = const [],
    this.selectedLanguage,
    this.currencies = const [],
    this.selectedCurrency,
    this.sizes = const [],
    this.selectedSize,
    this.errorMessage,
  });

  List<CountryEntity> get filteredCountries {
    final query = countrySearchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return countries;
    }
    return countries.where((c) {
      final nameLower = c.name.toLowerCase();
      final codeLower = c.code.toLowerCase();
      return nameLower.contains(query) ||
          codeLower.contains(query) ||
          query.contains(nameLower);
    }).toList();
  }

  PreferencesState copyWith({
    PreferencesStatus? status,
    List<CountryEntity>? countries,
    CountryEntity? selectedCountry,
    String? countrySearchQuery,
    List<LanguageEntity>? languages,
    LanguageEntity? selectedLanguage,
    List<CurrencyEntity>? currencies,
    CurrencyEntity? selectedCurrency,
    List<SizeStandardEntity>? sizes,
    SizeStandardEntity? selectedSize,
    String? errorMessage,
  }) {
    return PreferencesState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      countrySearchQuery: countrySearchQuery ?? this.countrySearchQuery,
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      currencies: currencies ?? this.currencies,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      sizes: sizes ?? this.sizes,
      selectedSize: selectedSize ?? this.selectedSize,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        countries,
        selectedCountry,
        countrySearchQuery,
        languages,
        selectedLanguage,
        currencies,
        selectedCurrency,
        sizes,
        selectedSize,
        errorMessage,
      ];
}
