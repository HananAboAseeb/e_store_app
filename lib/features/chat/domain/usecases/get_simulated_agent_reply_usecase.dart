import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chat_repository.dart';

class GetSimulatedAgentReplyUseCase implements UseCase<ChatMessageEntity, int> {
  final ChatRepository repository;

  GetSimulatedAgentReplyUseCase(this.repository);

  @override
  Future<Either<Failure, ChatMessageEntity>> call([int? param]) =>
      repository.getSimulatedAgentReply(replyIndex: param ?? 0);
}
