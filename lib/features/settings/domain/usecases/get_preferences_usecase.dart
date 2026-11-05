import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/country_entity.dart';
import '../entities/currency_entity.dart';
import '../entities/language_entity.dart';
import '../entities/size_standard_entity.dart';
import '../repositories/settings_repository.dart';

class PreferencesBundle extends Equatable {
  final List<CountryEntity> countries;
  final List<LanguageEntity> languages;
  final List<CurrencyEntity> currencies;
  final List<SizeStandardEntity> sizes;

  const PreferencesBundle({
    required this.countries,
    required this.languages,
    required this.currencies,
    required this.sizes,
  });

  @override
  List<Object?> get props => [countries, languages, currencies, sizes];
}

class GetPreferencesUseCase implements UseCase<PreferencesBundle, NoParam> {
  final SettingsRepository repository;

  GetPreferencesUseCase(this.repository);

  @override
  Future<Either<Failure, PreferencesBundle>> call([NoParam? param]) async {
    final results = await Future.wait([
      repository.getCountries(),
      repository.getLanguages(),
      repository.getCurrencies(),
      repository.getSizes(),
    ]);

    final countriesResult = results[0] as Either<Failure, List<CountryEntity>>;
    final languagesResult = results[1] as Either<Failure, List<LanguageEntity>>;
    final currenciesResult =
        results[2] as Either<Failure, List<CurrencyEntity>>;
    final sizesResult = results[3] as Either<Failure, List<SizeStandardEntity>>;

    return countriesResult.fold(
      (failure) => Left(failure),
      (countries) => languagesResult.fold(
        (failure) => Left(failure),
        (languages) => currenciesResult.fold(
          (failure) => Left(failure),
          (currencies) => sizesResult.fold(
            (failure) => Left(failure),
            (sizes) => Right(PreferencesBundle(
              countries: countries,
              languages: languages,
              currencies: currencies,
              sizes: sizes,
            )),
          ),
        ),
      ),
    );
  }
}
