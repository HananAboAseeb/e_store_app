import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/chat_review_entity.dart';
import '../repositories/chat_repository.dart';

class SubmitChatReviewUseCase implements UseCase<void, ChatReviewEntity> {
  final ChatRepository repository;

  SubmitChatReviewUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call([ChatReviewEntity? param]) {
    if (param == null) {
      return repository.submitReview(
        ChatReviewEntity(
          id: '',
          agentId: '',
          rating: 5,
          comment: '',
          submittedAt: DateTime.now(),
        ),
      );
    }
    return repository.submitReview(param);
  }
}
