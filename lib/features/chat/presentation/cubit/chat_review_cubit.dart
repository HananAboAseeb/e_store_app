import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_agent_entity.dart';
import '../../domain/entities/chat_review_entity.dart';
import '../../domain/usecases/submit_chat_review_usecase.dart';
import 'chat_review_state.dart';

class ChatReviewCubit extends Cubit<ChatReviewState> {
  final SubmitChatReviewUseCase submitChatReviewUseCase;

  ChatReviewCubit({required this.submitChatReviewUseCase})
      : super(const ChatReviewState());

  void init(ChatAgentEntity agent) {
    emit(
      ChatReviewState(
        status: ChatReviewStatus.writing,
        agent: agent,
        rating: 0,
        comment: '',
      ),
    );
  }

  void setRating(int rating) {
    emit(state.copyWith(rating: rating));
  }

  void setComment(String comment) {
    emit(state.copyWith(comment: comment));
  }

  Future<void> submit() async {
    if (state.rating <= 0) return;

    emit(state.copyWith(status: ChatReviewStatus.submitting));

    final review = ChatReviewEntity(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      agentId: state.agent.id,
      rating: state.rating,
      comment: state.comment,
      submittedAt: DateTime.now(),
    );

    final result = await submitChatReviewUseCase(review);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ChatReviewStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: ChatReviewStatus.submitted)),
    );
  }

  void reset() {
    emit(const ChatReviewState());
  }
}
