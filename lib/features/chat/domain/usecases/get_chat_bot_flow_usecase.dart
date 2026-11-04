import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/chat_bot_flow_entity.dart';
import '../repositories/chat_repository.dart';

class GetChatBotFlowUseCase implements UseCase<ChatBotFlowEntity, NoParam> {
  final ChatRepository repository;

  GetChatBotFlowUseCase(this.repository);

  @override
  Future<Either<Failure, ChatBotFlowEntity>> call([NoParam? param]) =>
      repository.getChatBotFlow();
}
