# Interface Contracts: Customer Care Support & Interactive Chat (Screens 68–80)

**Feature**: `specs/014-chat`  
**Date**: 2026-11-02  
**Status**: Completed  

---

## 1. Domain Repository Contract (`ChatRepository`)

```dart
abstract class ChatRepository {
  /// Fetches the bot welcome message, issue categories, order issues, and mock orders.
  Future<Either<Failure, ChatBotFlowEntity>> getChatBotFlow();

  /// Fetches the initial agent conversation setup including agent profile and triage history.
  Future<Either<Failure, List<ChatMessageEntity>>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryEntity selectedOrder,
  });

  /// Sends a customer message in the active chat.
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String text,
  });

  /// Obtains the next scripted or simulated agent reply in sequence.
  Future<Either<Failure, ChatMessageEntity>> getSimulatedAgentReply({
    required int replyIndex,
  });

  /// Submits customer service rating and review feedback.
  Future<Either<Failure, void>> submitReview(ChatReviewEntity review);
}
```

---

## 2. Data Source Contract (`ChatMockDataSource`)

```dart
abstract class ChatMockDataSource {
  Future<ChatBotFlowModel> getChatBotFlow();

  Future<List<ChatMessageModel>> getInitialAgentConversation({
    required String issueCategory,
    required String orderIssue,
    required ChatOrderSummaryModel selectedOrder,
  });

  Future<ChatMessageModel> sendMessage({required String text});

  Future<ChatMessageModel> getSimulatedAgentReply({required int replyIndex});

  Future<void> submitReview(ChatReviewModel review);
}
```

---

## 3. UI Navigation & Sheet Contracts

### Route Contract
- **Path**: `RouteNames.kChatPage` (`/chat`)
- **Type**: Fullscreen Page mounted at root navigator
- **Transition**: Standard push transition from Profile or external trigger
- **Arguments**: None required (optional `orderId` or `issue` pre-selection)

### Modal Contract (`ChatReviewSheet`)
```dart
class ChatReviewSheet {
  static Future<bool?> show(
    BuildContext context, {
    required ChatAgentEntity agent,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChatReviewSheet(agent: agent),
    );
  }
}
```
- **Returns**: `true` if review was submitted successfully; `null`/`false` if dismissed without submission.
- **Side Effect**: On successful review submission or dismissal at chat conclusion, navigates back to `/profile`.

