# Implementation Plan: Customer Care Support & Interactive Chat (Screens 68–80)

**Branch**: `014-chat` | **Date**: 2026-11-02 | **Spec**: [specs/014-chat/spec.md](spec.md)

**Input**: Feature specification from `specs/014-chat/spec.md` covering Screens 68–80.

---

## Summary

The Chat feature provides an integrated, end-to-end customer care support experience:
1. **Chat Bot Triage Flow (Screens 68, 69, 70)**: 3-step automated triage capturing issue category ("What's your issue?"), sub-issue details ("Order Issues"), and affected order selection ("Select your Order") via compact order summary cards.
2. **Agent Connection Handshake (Screens 71, 72, 73)**: Seamless transition converting bot triage choices into inline message history, displaying 3-dot "Connecting with an Agent" indicator, smooth header swap to agent Maggie Lee, and 3-dot "Typing..." bubble.
3. **Live Agent Conversation & Compensation Gifting (Screens 74, 75, 76, 77, 78, 79)**: Real-time style message exchange, inline 15% discount `VoucherCard` compensation gifting, and a floating "Scroll to Bottom" button when navigating older messages.
4. **Customer Care Review Modal (Screen 80)**: Modal bottom sheet allowing the customer to rate agent Maggie Lee using 5 interactive gold stars, enter comments, and submit feedback.

The implementation strictly follows Feature-First Clean Architecture, the project Constitution v1.2.0, Rule #11 (Strict Design Tokens), Rule #12 (FVM-Only CLI), and DRY component reuse.

---

## Technical Context

**Language/Version**: Dart 3.5.4 (Flutter 3.24.5 via FVM)  
**Primary Dependencies**: `flutter_bloc`, `go_router`, `flutter_screenutil`, `get_it`, `dartz`, `equatable`, `shimmer`  
**Storage**: In-memory mock data source (`ChatMockDataSourceImpl`)  
**Testing**: `flutter_test` (unit & widget tests in `test/features/chat/`)  
**Target Platform**: Android, iOS  
**Project Type**: Mobile Application Feature Module  
**Performance Goals**: 60 fps smooth scrolling and typing animations, instant chip selection (< 16ms), seamless transition across triage steps  
**Constraints**: Zero hardcoded colors/dimensions (Rule #11), FVM CLI only (Rule #12), no verification commands until final phase (Rule #1), zero new asset generation (Rule #2)  
**Scale/Scope**: 13 design reference screens, 3 Cubits, 5 UseCases, 1 standalone feature module  

---

## Constitution & Rule Compliance Check

| Rule | Requirement | Compliance Plan |
|---|---|---|
| Rule 1 | Verification Timing | Save static analysis strictly for the final phase (`fvm flutter analyze` at completion) |
| Rule 2 | Asset Policy | Reuse existing assets from `assets/images/` and `assets/design_references/`; 0 new assets generated |
| Rule 3 | Architectural Adherence | Feature-First Clean Architecture (`domain/`, `data/`, `presentation/`, `di/`) |
| Rule 4 | Code Quality & Design Patterns | UseCases with `Either<Failure, T>`, `safeCall` in repository, Cubits with `Equatable` states |
| Rule 5 | Dimensions & Frameworks | ScreenUtil (`.w`, `.h`, `.r`, `.sp`), `go_router` for navigation, `flutter_bloc` |
| Rule 6 | Component Reuse (DRY) | Reuse `PrimaryButton`, `VoucherCard`, `MetaPill`, `AppText`, `AppContainer`, `ModalCloseButton` |
| Rule 7 | Clean Architecture Layers | Complete Domain, Data, Presentation layers with DI registration and routing |
| Rule 8 | Phase 1 Data Scope | Mock data source with 5 issue categories, 5 order issues, 3 mock orders, Maggie Lee agent, and scripted conversation |
| Rule 9 | Loading Experience | Shimmer placeholders for initial bot flow loading and connecting states |
| Rule 10 | Visual Perfection | Pixel-perfect 1:1 match with Figma references (`68` through `80`) |
| Rule 11 | Strict Token Enforcement | 100% tokens from `AppColors`, `AppSpacing`, `AppTypography`. Add new tokens to `app_colors.dart` FIRST |
| Rule 12 | FVM-Only CLI Commands | Always use `fvm flutter` for all verification and build commands |

---

## Design Tokens to Add in Phase 1 (`lib/core/theme/app_colors.dart`)

The following tokens will be added to `AppColors` before widget implementation:
```dart
// ─────────────────────────────────────────────
// Chat Feature Colors (Screens 68–80)
// ─────────────────────────────────────────────
/// Gradient top for Chat background (Screens 68–79)
static const Color chatBgTop = Color(0xFFE8F1FD);

/// Gradient middle for Chat background (Screens 68–79)
static const Color chatBgMiddle = Color(0xFFFFFFFF);

/// Gradient bottom for Chat background (Screens 68–79)
static const Color chatBgBottom = Color(0xFFE8F1FD);

/// Light grey background for bot message bubbles (Screens 68–71)
static const Color botBubbleBg = Color(0xFFF2F4F8);

/// Primary blue for user message bubbles (Screens 71–79)
static const Color userBubbleBg = primary400;

/// Primary blue for agent message bubbles (Screens 73–79)
static const Color agentBubbleBg = primary400;

/// Active background for selected issue chip (Screens 68, 69)
static const Color chipActiveBg = primary400;

/// Border color for inactive issue chips (Screens 68, 69)
static const Color chipInactiveBorder = primary400;

/// Background for inactive issue chips (Screens 68, 69)
static const Color chipInactiveBg = Color(0xFFFFFFFF);

/// Grey color for 3-dot typing and connecting indicators (Screens 71, 72, 73)
static const Color typingDot = Color(0xFF8E8E93);

/// Gold color for selected rating stars in customer care review (Screen 80)
static const Color chatReviewStar = Color(0xFFFFAE00);

/// Soft light blue tint for comment input field in review modal (Screen 80)
static const Color chatReviewFieldBg = Color(0xFFF0F5FF);
```

---

## Component Reuse & DRY Strategy

### Existing Widgets to Reuse:
1. **`PrimaryButton`** (`lib/shared/widgets/primary_button.dart`): Reused for "Next" button in bot triage (Screens 68–70) and "Send Review" CTA in review modal (Screen 80).
2. **`VoucherCard`** (`lib/features/profile/presentation/widgets/voucher_card.dart`): Reused directly inside `ChatVoucherBubble` for inline 15% discount compensation (Screen 75).
3. **`MetaPill`** (`lib/shared/widgets/meta_pill.dart`): Reused for order metadata tags ("4 items", "Standard Delivery") inside `ChatOrderCard`.
4. **`AppText`** (`lib/shared/widgets/app_text.dart`): Reused for all titles, headings, message copy, and timestamps.
5. **`AppContainer`** (`lib/shared/widgets/app_container.dart`): Reused for grey backgrounds and structured surfaces.
6. **`ModalCloseButton`** (`lib/shared/widgets/modal_close_button.dart`): Reused for the circular `✕` close button in `ChatHeader` and `ChatReviewSheet`.
7. **Rating Stars Pattern** (`lib/features/product/presentation/widgets/review_card.dart`): Reused for rendering the 5 rating stars on Screen 80 with interactive tap handlers.
8. **`NoDataFoundWidget`** (`lib/shared/widgets/no_data_found_widget.dart`): Available for empty triage or message states.

### Justification for New Feature Widgets:
- **`ChatHeader`**: Combines dynamic Bot/Agent circular avatar, title ("Chat Bot" / "Maggie Lee"), subtitle ("Customer Care Service"), and `ModalCloseButton`. No existing header widget matches this dynamic agent handoff structure.
- **`ChatMessageBubble`**: Handles specialized bubble tails, 3 distinct sender variants (Bot left grey, User right blue, Agent left blue), multiline text wrapping, and timestamps.
- **`ChatVoucherBubble`**: Wraps the reused `VoucherCard` with proper chat margins and timestamp display.
- **`ChatOrderCard`**: Compact order card with product thumbnails row, delivery pill, item count, and toggle `Select`/`Selected` button for Screen 70 and inline message history. (Existing `OrderCard` is a full multi-section order card that does not fit compact chat constraints).
- **`ChatTypingIndicator`**: Staggered 3-dot pulsating animation widget for connecting (Screen 71) and agent typing (Screens 72, 73).
- **`ChatScrollToBottomButton`**: Floating circular blue button with white down arrow for Screen 78.
- **`ChatIssueChip`**: Specialized vertical issue option chip with active blue fill/checkmark and inactive white/blue-border styling for Screens 68 and 69.
- **`ChatBottomInput`**: Dedicated chat input bar combining message text field, Camera button, Document button, and Send trigger for Screens 71–79.
- **`ChatReviewSheet`**: Modal bottom sheet for Screen 80 combining agent header, 5-star rating, comment field, and `PrimaryButton`.

---

## Technical Decisions

### 1. Unification of Screens 68–79 (`ChatPage`)
- All 12 contiguous conversation screens are rendered within a single `ChatPage` widget at route `/chat`.
- The screen layout consists of:
  - **Header**: `ChatHeader` updating from Bot identity to Agent Maggie Lee.
  - **Body**: Animated crossfade / conditional layout switching between Bot Triage (Screens 68–70) and Message Stream (Screens 71–79).
  - **Bottom Action Area**: Triage navigation buttons (Screens 68–70) vs. `ChatBottomInput` (Screens 71–79).
- When transitioning from Screen 70 to 71, user selections and the selected `ChatOrderCard` are automatically converted into initial messages in `AgentChatCubit`.

### 2. CSS-Like Flutter Gradient Background
- Implemented with Flutter `BoxDecoration` and vertical `LinearGradient` across `AppColors.chatBgTop`, `AppColors.chatBgMiddle`, and `AppColors.chatBgBottom`.
- Zero image files used, 100% compliant with Rule #2 and Rule #11.

### 3. Three-Cubit State Management Architecture
- **`ChatBotCubit`**: Handles triage steps (Screens 68, 69, 70), chip selections, and order choice.
- **`AgentChatCubit`**: Handles live conversation (Screens 71–79), simulated typing delays (1.5–2s), message appending, and scroll-to-bottom visibility.
- **`ChatReviewCubit`**: Handles feedback rating (1–5 stars) and comment submission (Screen 80).

### 4. Smart Scroll-To-Bottom Floating Button (Screen 78)
- A `ScrollController` listener detects when the user scrolls up past 150dp from the bottom and triggers `showScrollToBottom = true`.
- Tapping `ChatScrollToBottomButton` triggers `animateTo(0.0)` to smoothly return to the newest message.

### 5. Customer Care Review Modal (Screen 80)
- Invoked via `ChatReviewSheet.show(context, agent: ...)` upon tapping the close button or concluding the chat.
- Rounded top corners (`24.r`), 5 interactive stars, comment input with `AppColors.chatReviewFieldBg`, and `PrimaryButton('Send Review')`.
- Dismissal or submission smoothly pops the modal and routes back to `/profile`.

---

## Project Structure & Source Code Layout

```text
lib/
├── core/
│   └── theme/
│       └── app_colors.dart                               # Add chat color tokens (Rule #11)
├── config/
│   └── routing/
│       ├── route_names.dart                              # Add kChatPage = '/chat'
│       └── app_router.dart                               # Register /chat route
└── features/
    └── chat/
        ├── chat_injection.dart                           # GetIt DI module for Chat feature
        ├── domain/
        │   ├── entities/
        │   │   ├── chat_message_entity.dart              # ChatMessageEntity, ChatAttachmentEntity
        │   │   ├── chat_order_summary_entity.dart        # ChatOrderSummaryEntity
        │   │   ├── chat_bot_flow_entity.dart             # ChatBotFlowEntity
        │   │   ├── chat_agent_entity.dart                # ChatAgentEntity
        │   │   └── chat_review_entity.dart               # ChatReviewEntity
        │   ├── repositories/
        │   │   └── chat_repository.dart                  # ChatRepository contract
        │   └── usecases/
        │       ├── get_chat_bot_flow_usecase.dart        # Fetch triage options & orders
        │       ├── get_initial_agent_conversation_usecase.dart # Handoff triage to agent
        │       ├── send_message_usecase.dart             # Send user message
        │       ├── get_simulated_agent_reply_usecase.dart# Scripted agent responses
        │       └── submit_chat_review_usecase.dart       # Submit service review
        ├── data/
        │   ├── models/
        │   │   ├── chat_message_model.dart               # ChatMessageModel, ChatAttachmentModel
        │   │   ├── chat_order_summary_model.dart         # ChatOrderSummaryModel
        │   │   ├── chat_bot_flow_model.dart              # ChatBotFlowModel
        │   │   ├── chat_agent_model.dart                 # ChatAgentModel
        │   │   └── chat_review_model.dart                # ChatReviewModel
        │   ├── datasources/
        │   │   ├── chat_mock_datasource.dart             # Mock datasource contract
        │   │   └── chat_mock_datasource_impl.dart        # Mock datasource implementation
        │   └── repositories/
        │       └── chat_repository_impl.dart             # Repository implementation using safeCall
        └── presentation/
            ├── cubit/
            │   ├── chat_bot_cubit.dart                   # ChatBotCubit
            │   ├── chat_bot_state.dart                   # ChatBotState
            │   ├── agent_chat_cubit.dart                 # AgentChatCubit
            │   ├── agent_chat_state.dart                 # AgentChatState
            │   ├── chat_review_cubit.dart                # ChatReviewCubit
            │   └── chat_review_state.dart                # ChatReviewState
            ├── pages/
            │   └── chat_page.dart                        # Unified ChatPage (Screens 68–79)
            └── widgets/
                ├── chat_header.dart                      # Bot/Agent header with close button
                ├── chat_message_bubble.dart              # Bot/User/Agent message bubbles
                ├── chat_voucher_bubble.dart              # Inline VoucherCard wrapper (Screen 75)
                ├── chat_order_card.dart                  # Compact order summary card (Screen 70)
                ├── chat_typing_indicator.dart            # 3-dot animated pulsating indicator
                ├── chat_scroll_to_bottom_button.dart     # Floating jump button (Screen 78)
                ├── chat_issue_chip.dart                  # Selectable issue option chip (Screens 68, 69)
                ├── chat_bottom_input.dart                # Message input bar with icons (Screens 71–79)
                └── chat_review_sheet.dart                # Customer care review modal (Screen 80)
```

---

## Permanent Project Rules Reference

All plans MUST strictly incorporate and reflect the Permanent Project Rules from `.specify/memory/constitution.md`:
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (.w, .h, .r, .sp). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
12. **FVM-ONLY CLI COMMANDS**: ALWAYS use `fvm flutter` (NOT bare `flutter`) for ALL Flutter CLI commands (`analyze`, `test`, `run`, `build`, `pub get`, etc.).
