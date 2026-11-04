# Data Model: Customer Care Support & Interactive Chat (Screens 68–80)

**Feature**: `specs/014-chat`  
**Date**: 2026-11-02  
**Status**: Completed  

---

## 1. Domain Entities (`lib/features/chat/domain/entities/`)

### `ChatMessageEntity`
Represents an individual message inside the chat stream.
```dart
enum ChatMessageSender { bot, user, agent }

class ChatMessageEntity extends Equatable {
  final String id;
  final ChatMessageSender sender;
  final String text;
  final String timestamp; // e.g. "12:45 PM"
  final ChatAttachmentEntity? attachment;

  const ChatMessageEntity({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.attachment,
  });

  @override
  List<Object?> get props => [id, sender, text, timestamp, attachment];
}
```

### `ChatAttachmentEntity`
Represents rich embedded items inside the chat stream (orders, vouchers).
```dart
enum ChatAttachmentType { order, voucher }

class ChatAttachmentEntity extends Equatable {
  final ChatAttachmentType type;
  final ChatOrderSummaryEntity? order;
  final VoucherEntity? voucher;

  const ChatAttachmentEntity({
    required this.type,
    this.order,
    this.voucher,
  });

  @override
  List<Object?> get props => [type, order, voucher];
}
```

### `ChatOrderSummaryEntity`
Represents a compact order item for triage selection (Screen 70) and inline chat display (Screens 71–79).
```dart
class ChatOrderSummaryEntity extends Equatable {
  final String id;
  final String orderNumber; // e.g. "#655541"
  final String deliveryType; // e.g. "Standard Delivery"
  final int itemCount; // e.g. 4
  final String status; // "Shipped" or "Delivered"
  final String thumbnailUrl; // e.g. "assets/images/home_flash_1.png"
  final bool isSelected;

  const ChatOrderSummaryEntity({
    required this.id,
    required this.orderNumber,
    required this.deliveryType,
    required this.itemCount,
    required this.status,
    required this.thumbnailUrl,
    this.isSelected = false,
  });

  ChatOrderSummaryEntity copyWith({bool? isSelected}) {
    return ChatOrderSummaryEntity(
      id: id,
      orderNumber: orderNumber,
      deliveryType: deliveryType,
      itemCount: itemCount,
      status: status,
      thumbnailUrl: thumbnailUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, orderNumber, deliveryType, itemCount, status, thumbnailUrl, isSelected];
}
```

### `ChatBotFlowEntity`
Represents the configuration and choices available in the automated bot triage flow (Screens 68–70).
```dart
class ChatBotFlowEntity extends Equatable {
  final String welcomeMessage;
  final List<String> issueCategories;
  final List<String> orderIssues;
  final List<ChatOrderSummaryEntity> orders;

  const ChatBotFlowEntity({
    required this.welcomeMessage,
    required this.issueCategories,
    required this.orderIssues,
    required this.orders,
  });

  @override
  List<Object?> get props => [welcomeMessage, issueCategories, orderIssues, orders];
}
```

### `ChatAgentEntity`
Represents the customer support agent identity (Maggie Lee).
```dart
class ChatAgentEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;

  const ChatAgentEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, role, avatarUrl];
}
```

### `ChatReviewEntity`
Represents customer satisfaction rating and review (Screen 80).
```dart
class ChatReviewEntity extends Equatable {
  final String id;
  final String agentId;
  final int rating; // 1 to 5
  final String comment;
  final DateTime submittedAt;

  const ChatReviewEntity({
    required this.id,
    required this.agentId,
    required this.rating,
    required this.comment,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [id, agentId, rating, comment, submittedAt];
}
```

---

## 2. Data Models (`lib/features/chat/data/models/`)

Each domain entity has a corresponding data model extending the entity and implementing `fromMap` / `toMap` serialization:
- `ChatMessageModel` extends `ChatMessageEntity`
- `ChatAttachmentModel` extends `ChatAttachmentEntity`
- `ChatOrderSummaryModel` extends `ChatOrderSummaryEntity`
- `ChatBotFlowModel` extends `ChatBotFlowEntity`
- `ChatAgentModel` extends `ChatAgentEntity`
- `ChatReviewModel` extends `ChatReviewEntity`

---

## 3. State Models (`lib/features/chat/presentation/cubit/`)

### `ChatBotState`
```dart
enum ChatBotStep { issue, orderIssue, selectOrder, completed }

class ChatBotState extends Equatable {
  final ChatBotStep step;
  final String selectedIssue;
  final String selectedOrderIssue;
  final ChatOrderSummaryEntity? selectedOrder;
  final List<String> issueCategories;
  final List<String> orderIssues;
  final List<ChatOrderSummaryEntity> orders;
  final bool isLoading;
  final String? errorMessage;
  // ...
}
```

### `AgentChatState`
```dart
enum AgentChatPhase { connecting, typing, active, closed }

class AgentChatState extends Equatable {
  final AgentChatPhase phase;
  final ChatAgentEntity agent;
  final List<ChatMessageEntity> messages;
  final bool isTyping;
  final bool showScrollToBottom;
  final String? errorMessage;
  // ...
}
```

### `ChatReviewState`
```dart
enum ChatReviewStatus { initial, writing, submitting, submitted, error }

class ChatReviewState extends Equatable {
  final ChatReviewStatus status;
  final ChatAgentEntity agent;
  final int rating;
  final String comment;
  final String? errorMessage;
  // ...
}
```

