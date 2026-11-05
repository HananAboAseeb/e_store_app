import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../repositories/settings_repository.dart';

enum PreferenceType { country, language, currency, size }

class UpdatePreferenceParams extends Equatable {
  final PreferenceType type;
  final String value;

  const UpdatePreferenceParams({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [type, value];
}

class UpdatePreferenceUseCase implements UseCase<void, UpdatePreferenceParams> {
  final SettingsRepository repository;

  UpdatePreferenceUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([UpdatePreferenceParams? param]) async {
    if (param != null) {
      return await repository.updatePreference(param.type.name, param.value);
    }
    return const Right(null);
  }
}
