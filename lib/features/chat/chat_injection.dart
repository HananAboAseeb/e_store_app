import '../../core/di/injection_container.dart';
import 'data/datasources/chat_mock_datasource.dart';
import 'data/datasources/chat_mock_datasource_impl.dart';
import 'data/repositories/chat_repository_impl.dart';
import 'domain/repositories/chat_repository.dart';
import 'domain/usecases/get_chat_bot_flow_usecase.dart';
import 'domain/usecases/get_initial_agent_conversation_usecase.dart';
import 'domain/usecases/get_simulated_agent_reply_usecase.dart';
import 'domain/usecases/send_message_usecase.dart';
import 'domain/usecases/submit_chat_review_usecase.dart';
import 'presentation/cubit/agent_chat_cubit.dart';
import 'presentation/cubit/chat_bot_cubit.dart';
import 'presentation/cubit/chat_review_cubit.dart';

void initChatInjection() {
  // Data Source
  sl.registerLazySingleton<ChatMockDataSource>(
    () => ChatMockDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(mockDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetChatBotFlowUseCase(sl()));
  sl.registerLazySingleton(() => GetInitialAgentConversationUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetSimulatedAgentReplyUseCase(sl()));
  sl.registerLazySingleton(() => SubmitChatReviewUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => ChatBotCubit(getChatBotFlowUseCase: sl()),
  );
  sl.registerFactory(
    () => AgentChatCubit(
      getInitialAgentConversationUseCase: sl(),
      sendMessageUseCase: sl(),
      getSimulatedAgentReplyUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ChatReviewCubit(submitChatReviewUseCase: sl()),
  );
}
