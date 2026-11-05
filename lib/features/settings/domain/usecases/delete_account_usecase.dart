import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../repositories/settings_repository.dart';

class DeleteAccountUseCase implements UseCase<void, NoParam> {
  final SettingsRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([NoParam? param]) =>
      repository.deleteAccount();
}
