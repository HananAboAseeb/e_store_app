# Technical Research: Customer Care Support & Interactive Chat (Screens 68–80)

**Feature**: `specs/014-chat`  
**Date**: 2026-11-02  
**Status**: Completed  

---

## 1. Unified Chat Page Architecture (Screens 68–79)

### Decision
Unify all chat screens (68 to 79) into a single route (`/chat`) hosting a unified `ChatPage` widget. The screen layout consists of three primary zones:
1. **Top Header (`ChatHeader`)**: Dynamically displays either the Bot identity (Screens 68–71) or Agent Maggie Lee (Screens 72–79) based on the active Cubit phase.
2. **Center Message Stream / Triage Area**:
   - In Bot Triage mode (Screens 68–70), displays the initial bot message and the step-specific question prompt with selectable chips or compact order cards.
   - In Live Agent mode (Screens 71–79), displays the scrollable `ListView` of `ChatMessageEntity` instances (including embedded order cards, voucher cards, and animated typing bubbles).
3. **Bottom Action / Input Bar**:
   - In Bot Triage mode, renders the primary `Next` / Back navigation controls.
   - In Agent Connection mode (Screen 71), renders disabled input.
   - In Live Agent mode (Screens 72–79), renders the full interactive `ChatBottomInput` (text field, camera button, document button, and send action).

### Rationale
- Creating separate routes for 12 contiguous conversation screens would cause disruptive page transitions, loss of keyboard state, and unnecessary route stack bloat.
- A single state-driven `ChatPage` ensures seamless continuity as bot triage seamlessly converts into conversation history when handing off to the live agent on Screen 71.

### Alternatives Considered
- *Separate routes (`/chat/bot`, `/chat/connecting`, `/chat/agent`)*: Rejected because it breaks message list continuity, restarts scroll positions, and prevents natural smooth transitions between typing states.
- *IndexedStack of pages*: Rejected because message history must naturally incorporate triage selections as prior message bubbles.

---

## 2. CSS-Like Flutter Gradient Background Decoration

### Decision
Construct the chat background using Flutter's `BoxDecoration` with a vertical `LinearGradient` instead of any static image asset:
```dart
BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.chatBgTop,
      AppColors.chatBgMiddle,
      AppColors.chatBgBottom,
    ],
    stops: const [0.0, 0.45, 1.0],
  ),
)
```

### Rationale
- Complies strictly with Rule #2 (Asset Policy: zero new image files).
- Perfectly matches the Figma design reference (light blue at top, soft white through center message reading zone, and light blue tint at bottom).
- Renders with native 60/120 fps GPU efficiency across all screen dimensions.

### Alternatives Considered
- *Asset image overlay (`assets/images/chat_bg.png`)*: Strictly forbidden by Rule #2.
- *Solid background color*: Rejected because it fails pixel-perfect Figma fidelity (Screens 68–79 clearly use a vertical gradient).

---

## 3. Typing & Connection Indicator Animation

### Decision
Build a lightweight `ChatTypingIndicator` widget using a single `AnimationController` that drives 3 circular dots with staggered phase offsets (`interval` delays of 0.0–0.6, 0.2–0.8, 0.4–1.0).
- Dots oscillate vertically (`Transform.translate`) or pulse in opacity and scale (`0.4` to `1.0`).
- Token color: `AppColors.typingDot` (`Color(0xFF8E8E93)`).

### Rationale
- Pure Flutter animation with zero third-party dependencies.
- Reusable for both Screen 71 ("Connecting with an Agent" with 3 dots) and Screen 72/73 ("Typing..." with 3 dots).
- Performs efficiently on the Flutter render thread with no memory leaks.

### Alternatives Considered
- *External package (e.g. `loading_animation_widget`)*: Rejected to avoid adding third-party dependencies when Flutter built-in animations handle this in ~40 lines of code.
- *Static ellipsis text (`...`)*: Rejected because the Figma design calls for animated pulsating dots.

---

## 4. Scroll-To-Bottom Floating Button

### Decision
Implement a scroll listener on `ScrollController` in `ChatPage`:
- When `scrollController.offset > 150.h` (indicating the user has scrolled up past the latest messages), set local state or emit cubit flag `showScrollToBottom = true`.
- Render `ChatScrollToBottomButton` in a floating position using `Positioned` in a `Stack` right above the bottom input bar.
- On tap, trigger `scrollController.animateTo(0.0, duration: 300ms, curve: Curves.easeOut)`.

### Rationale
- Perfectly reflects Screen 78 (*SCROLL TO THE BOTTOM*).
- Prevents UI occlusion while offering a fast return mechanism when reviewing earlier triage options or compensation vouchers.

### Alternatives Considered
- *Always-visible jump button*: Rejected because it clutters the UI when the user is already at the bottom.
- *FloatingActionButton in Scaffold*: Position is fixed by Flutter's Scaffold and conflicts with bottom chat input padding; using `Stack` and `Positioned` provides exact pixel control.

---

## 5. Inline Widget Embedding (VoucherCard & Compact ChatOrderCard)

### Decision
Use a discriminated union pattern in `ChatMessageEntity`:
- `ChatMessageEntity` has an optional `ChatAttachmentEntity? attachment`.
- When `attachment?.type == ChatAttachmentType.voucher`, the message list delegates rendering to `ChatVoucherBubble`, which wraps the existing `VoucherCard` from `lib/features/profile/presentation/widgets/voucher_card.dart`.
- When `attachment?.type == ChatAttachmentType.order`, the message list delegates rendering to `ChatOrderCard`, which reuses `MetaPill` and `AppText`.

### Rationale
- 100% DRY reuse of `VoucherCard` and `MetaPill`.
- Keeps the chat timeline extensible for any future rich commerce entities.

---

## 6. Customer Care Review Modal (Screen 80)

### Decision
Present `ChatReviewSheet` using `showModalBottomSheet`:
- `isScrollControlled: true` to prevent keyboard clipping.
- `backgroundColor: Colors.transparent`.
- Rounded top container with `24.r` radius matching `AppColors.surface`.
- Reuses `ModalCloseButton` from `lib/shared/widgets/modal_close_button.dart`.
- Reuses `PrimaryButton` for "Send Review".
- Star rating uses interactive `GestureDetector` over 5 star icons with `AppColors.chatReviewStar` (`#FFAE00`).

### Rationale
- Clean standard Flutter modal sheet lifecycle.
- Decoupled from the chat page routing; closing or submitting dismisses the sheet and smoothly navigates back to `/profile`.

