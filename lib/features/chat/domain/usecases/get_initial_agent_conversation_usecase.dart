import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../shared/use_cases/use_case.dart';
import '../entities/chat_message_entity.dart';
import '../entities/chat_order_summary_entity.dart';
import '../repositories/chat_repository.dart';

class InitialConversationParams extends Equatable {
  final String issueCategory;
  final String orderIssue;
  final ChatOrderSummaryEntity selectedOrder;

  const InitialConversationParams({
    required this.issueCategory,
    required this.orderIssue,
    required this.selectedOrder,
  });

  @override
  List<Object?> get props => [issueCategory, orderIssue, selectedOrder];
}

class GetInitialAgentConversationUseCase
    implements UseCase<List<ChatMessageEntity>, InitialConversationParams> {
  final ChatRepository repository;

  GetInitialAgentConversationUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> call([
    InitialConversationParams? param,
  ]) {
    if (param == null) {
      return repository.getInitialAgentConversation(
        issueCategory: '',
        orderIssue: '',
        selectedOrder: const ChatOrderSummaryEntity(
          id: '',
          orderNumber: '',
          deliveryType: '',
          itemCount: 0,
          status: '',
          thumbnailUrl: '',
        ),
      );
    }
    return repository.getInitialAgentConversation(
      issueCategory: param.issueCategory,
      orderIssue: param.orderIssue,
      selectedOrder: param.selectedOrder,
    );
  }
}
