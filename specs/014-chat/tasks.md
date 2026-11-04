# Tasks: Customer Care Support & Interactive Chat (Screens 68–80)

**Input**: Design documents from `specs/014-chat/` (`spec.md`, `plan.md`, `data-model.md`, `contracts/chat_contracts.md`, `research.md`, `quickstart.md`)  
**Prerequisites**: All permanent project rules in `.specify/instructions/permanent-project-rules.md` and Constitution v1.2.0  
**Verification Timing**: No `fvm flutter analyze` or `fvm flutter test` until Phase 7 (final phase only)  

---

## Format: `[ID] [P?] [Story?] Description with file path`
- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g. `[US1]`, `[US2]`, `[US3]`, `[US4]`)
- Every task includes explicit file paths

---

## Phase 1: Setup & Token Scaffolding (Shared Infrastructure)

**Purpose**: Register all 13 new tokens in `AppColors` FIRST before any UI implementation begins, and establish the feature directory structure.

- [X] T001 Register 13 new tokens (`chatBgTop`, `chatBgMiddle`, `chatBgBottom`, `botBubbleBg`, `userBubbleBg`, `agentBubbleBg`, `chipActiveBg`, `chipInactiveBorder`, `chipInactiveBg`, `typingDot`, `chatReviewStar`, `chatReviewFieldBg`, `chatReviewFieldBorder`) in `lib/core/theme/app_colors.dart` FIRST.
- [X] T002 [P] Establish directory structure for chat subpackages under `lib/features/chat/` (`domain/entities`, `domain/repositories`, `domain/usecases`, `data/models`, `data/datasources`, `data/repositories`, `presentation/cubit`, `presentation/pages`, `presentation/widgets`).

---

## Phase 2: Foundational (Domain, Data, DI & Routing)

**Purpose**: Core Clean Architecture contracts, entities, use cases, data models, mock data sources, DI container, and navigation routing.

- [X] T003 [P] Create domain entities (`ChatMessageEntity`, `ChatAttachmentEntity`, `ChatOrderSummaryEntity`, `ChatBotFlowEntity`, `ChatAgentEntity`, `ChatReviewEntity`) and enums (`ChatMessageSender`, `ChatAttachmentType`, `ChatBotStep`, `AgentChatPhase`, `ChatReviewStatus`) in `lib/features/chat/domain/entities/`.
- [X] T004 [P] Define `ChatRepository` interface contract in `lib/features/chat/domain/repositories/chat_repository.dart`.
- [X] T005 [P] Implement 5 UseCases (`GetChatBotFlowUseCase`, `GetInitialAgentConversationUseCase`, `SendMessageUseCase`, `GetSimulatedAgentReplyUseCase`, `SubmitChatReviewUseCase`) in `lib/features/chat/domain/usecases/`.
- [X] T006 [P] Implement 6 Data Models (`ChatMessageModel`, `ChatAttachmentModel`, `ChatOrderSummaryModel`, `ChatBotFlowModel`, `ChatAgentModel`, `ChatReviewModel`) extending entities with `fromMap`/`toMap` in `lib/features/chat/data/models/`.
- [X] T007 Implement `ChatMockDataSource` and `ChatMockDataSourceImpl` in `lib/features/chat/data/datasources/chat_mock_datasource.dart` and `lib/features/chat/data/datasources/chat_mock_datasource_impl.dart` (5 issue categories, 5 order issues, 3 mock orders `#655541` etc., Maggie Lee agent, scripted conversation history).
- [X] T008 Implement `ChatRepositoryImpl` in `lib/features/chat/data/repositories/chat_repository_impl.dart` wrapping data source calls with `safeCall`.
- [X] T009 [P] Register route constant `kChatPage = '/chat'` in `lib/config/routing/route_names.dart` and mount `/chat` in `lib/config/routing/app_router.dart`.
- [X] T010 Register all 3 Cubits, 5 UseCases, Repository, and MockDataSource in `lib/features/chat/chat_injection.dart` and bind into `lib/core/di/injection.dart`.

**Checkpoint**: Foundation complete — data contracts, mock data sources, DI bindings, and routing ready for presentation layer.

---

## Phase 3: User Story 1 (P1) — Chat Bot Flow (Screens 68, 69, 70) 🎯 MVP

**Goal**: Deliver the 3-step automated triage flow capturing issue category ("What's your issue?"), sub-issue details ("Order Issues"), and affected order selection ("Select your Order") via compact order summary cards.  
**Independent Test**: Navigate to `/chat`; verify vertical gradient background, bot welcome message bubble, select issue chips across Screens 68 and 69, verify back/next navigation, select an order card on Screen 70, and confirm transition to agent connection.

- [X] T011 [US1] Implement `ChatBotCubit` and `ChatBotState` in `lib/features/chat/presentation/cubit/chat_bot_cubit.dart` and `lib/features/chat/presentation/cubit/chat_bot_state.dart` (managing triage steps `issue`, `orderIssue`, `selectOrder`, selection state, and back/next navigation).
- [X] T012 [P] [US1] Implement `ChatIssueChip` in `lib/features/chat/presentation/widgets/chat_issue_chip.dart` (vertical selectable chip with active blue fill/checkmark and inactive white/blue-border styling using `AppColors.chipActiveBg`, `AppColors.chipInactiveBorder`, `AppColors.chipInactiveBg`, and `AppText`).
- [X] T013 [P] [US1] Implement compact `ChatOrderCard` in `lib/features/chat/presentation/widgets/chat_order_card.dart` (compact card with item thumbnails row, order number `#655541`, `MetaPill` tags for "Standard Delivery" and "4 items", order status, and `Select`/`Selected` button reusing `PrimaryButton` and `AppText`).
- [X] T014 [US1] Implement base `ChatPage` with CSS-like gradient background (`BoxDecoration` with `LinearGradient` `chatBgTop` → `chatBgMiddle` → `chatBgBottom`), wire `ChatBotCubit`, and assemble Bot Triage views for Screens 68, 69, and 70 with back navigation and `PrimaryButton('Next')` in `lib/features/chat/presentation/pages/chat_page.dart`.

**Checkpoint**: User Story 1 complete and independently verifiable as the core triage MVP.

---

## Phase 4: User Story 2 (P2) — Agent Handshake & Live Conversation (Screens 71, 72, 73, 74)

**Goal**: Seamlessly transition from bot triage to human agent connection, displaying prior selections as message history, animated typing indicators, dynamic header swap to agent Maggie Lee, and conversational message bubbles.  
**Independent Test**: Complete triage or start agent chat; verify Screen 71 "Connecting with an Agent" with 3 animated dots and disabled input, observe header transition to Maggie Lee on Screen 72 with "Typing..." bubble, observe agent greeting on Screen 73, and send a reply to receive order status on Screen 74.

- [X] T015 [US2] Implement `AgentChatCubit` and `AgentChatState` in `lib/features/chat/presentation/cubit/agent_chat_cubit.dart` and `lib/features/chat/presentation/cubit/agent_chat_state.dart` (managing `connecting`, `typing`, `active` phases, 2s auto-transitions, message list, and simulated agent responses).
- [X] T016 [P] [US2] Implement `ChatHeader` in `lib/features/chat/presentation/widgets/chat_header.dart` (reusable header displaying circular Bot logo or Maggie Lee avatar, dynamic title, "Customer Care Service" subtitle, and circular `ModalCloseButton`).
- [X] T017 [P] [US2] Implement `ChatTypingIndicator` in `lib/features/chat/presentation/widgets/chat_typing_indicator.dart` (staggered 3-dot pulsating scale/opacity animation using `AppColors.typingDot`).
- [X] T018 [P] [US2] Implement `ChatMessageBubble` in `lib/features/chat/presentation/widgets/chat_message_bubble.dart` (Bot left grey bubble with `AppColors.botBubbleBg`, User right blue bubble with `AppColors.userBubbleBg`, Agent left blue bubble with `AppColors.agentBubbleBg`, supporting embedded `ChatOrderCard` and timestamps).
- [X] T019 [US2] Integrate Agent Handshake and Live Conversation into `ChatPage` in `lib/features/chat/presentation/pages/chat_page.dart` (connecting indicator on Screen 71, header transition to Maggie Lee on Screen 72, typing indicator bubble, first agent message on Screen 73, user reply and order explanation on Screen 74).

**Checkpoint**: User Story 2 complete and independently verifiable.

---

## Phase 5: User Story 3 (P3) — Voucher Compensation & Interactive Messaging (Screens 75, 76, 77, 78, 79)

**Goal**: Deliver in-chat 15% discount voucher compensation, active messaging with camera/document buttons, smart scroll-to-bottom floating button, and conversation wrap-up.  
**Independent Test**: Progress to Screen 75; verify inline ticket `VoucherCard` appears in the timeline, send replies ("Wow! Thanks a lot, Maggy!"), scroll up to confirm floating `ChatScrollToBottomButton` appears on Screen 78, tap it to jump back to bottom, and observe wrap-up message on Screen 79.

- [X] T020 [P] [US3] Implement `ChatVoucherBubble` in `lib/features/chat/presentation/widgets/chat_voucher_bubble.dart` (wrapping the existing `VoucherCard` from `lib/features/profile/presentation/widgets/voucher_card.dart` for Screen 75 with chat alignment, padding, and timestamp).
- [X] T021 [P] [US3] Implement `ChatBottomInput` in `lib/features/chat/presentation/widgets/chat_bottom_input.dart` (multiline-capable message text field, Camera button, Document button, and Send button, with disabled state for Screen 71 and active state for Screens 73–79).
- [X] T022 [P] [US3] Implement `ChatScrollToBottomButton` in `lib/features/chat/presentation/widgets/chat_scroll_to_bottom_button.dart` (circular blue floating button with white down arrow for Screen 78).
- [X] T023 [US3] Wire voucher gifting (Screen 75), interactive messaging (Screens 76, 77, 79), and scroll-to-bottom controller listener (Screen 78) into `AgentChatCubit` and `ChatPage` in `lib/features/chat/presentation/pages/chat_page.dart`.

**Checkpoint**: User Story 3 complete and independently verifiable.

---

## Phase 6: User Story 4 (P4) — Customer Care Review Modal (Screen 80)

**Goal**: Deliver the Customer Care Review modal sheet allowing the customer to rate agent Maggie Lee using 5 interactive gold stars, enter comments, and submit feedback.  
**Independent Test**: Tap top-right close `✕` button or conclude chat; verify modal sheet slides up with rounded top corners (`24.r`), Maggie Lee info, tap stars to update gold rating (`#FFAE00`), enter comments, tap `Send Review`, verify submission feedback, and confirm navigation back to `/profile`.

- [X] T024 [US4] Implement `ChatReviewCubit` and `ChatReviewState` in `lib/features/chat/presentation/cubit/chat_review_cubit.dart` and `lib/features/chat/presentation/cubit/chat_review_state.dart` (managing 1–5 star rating, feedback comment text, submission state, and reset).
- [X] T025 [P] [US4] Implement `ChatReviewSheet` in `lib/features/chat/presentation/widgets/chat_review_sheet.dart` (modal bottom sheet with 24.r top radius, `ModalCloseButton`, agent info header, 5 interactive rating stars using `AppColors.chatReviewStar`, multiline comment input with `AppColors.chatReviewFieldBg`, and `PrimaryButton('Send Review')`).
- [X] T026 [US4] Integrate `ChatReviewSheet.show(context, agent: ...)` trigger on chat close button (`✕`) and upon chat resolution in `lib/features/chat/presentation/pages/chat_page.dart`, navigating back to `/profile` on submit or dismiss.

**Checkpoint**: User Story 4 complete; all 13 screens (68 to 80) implemented and fully functional.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements, formatting, code cleanup, static analysis, and automated widget tests. Run strictly once at the end.

- [X] T027 [P] Code cleanup, formatting (`dart format`), verifying 100% token usage (no hardcoded colors, spacing, or typography), and verifying DRY widget reuse.
- [X] T028 [P] Create comprehensive widget tests for Chat Bot triage, agent messaging, and review modal in `test/features/chat/presentation/chat_page_test.dart`.
- [X] T029 Execute static analysis verification (`fvm flutter analyze`) and ensure 0 errors and 0 warnings across the entire codebase.

---

## Dependencies & Execution Order

```text
Phase 1 (Tokens & Scaffolding)
  └── Phase 2 (Domain, Data, DI & Routing)
        └── Phase 3 (US1: Chat Bot Flow 🎯 MVP)
              └── Phase 4 (US2: Agent Handshake & Live Conversation)
                    └── Phase 5 (US3: Voucher Gifting & Interactive Messaging)
                          └── Phase 6 (US4: Customer Care Review Modal)
                                └── Phase 7 (Polish, Tests, flutter analyze)
```

### Parallel Opportunities Identified:
- Phase 1: `T002` [P] parallel with `T001`.
- Phase 2: `T003`, `T004`, `T005`, `T006`, `T009` [P] can run in parallel before assembly.
- Phase 3: `T012` [P], `T013` [P] parallel before `T014`.
- Phase 4: `T016` [P], `T017` [P], `T018` [P] parallel before `T019`.
- Phase 5: `T020` [P], `T021` [P], `T022` [P] parallel before `T023`.
- Phase 6: `T025` [P] parallel with `T024` before `T026`.
- Phase 7: `T027` [P], `T028` [P] parallel before `T029`.
