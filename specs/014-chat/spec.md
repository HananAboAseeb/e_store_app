# Feature Specification: Customer Care Support & Interactive Chat (Screens 68–80)

**Feature Directory**: `specs/014-chat`

**Feature Branch**: `feat/customer-care-chat`

**Created**: 2026-11-02

**Status**: Ready for Planning

**Input**: User description: "Chat feature covering Screens 68–80: Chat Bot Flow (Screens 68, 69, 70), Agent Connection & Typing (Screens 71, 72, 73), Agent Conversation & Voucher Gifting (Screens 74, 75, 76, 77, 78, 79), and Customer Care Review modal (Screen 80)"

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Automated Bot Triage & Order Issue Categorization (Screens 68, 69, 70) (Priority: P1)

As a customer experiencing an order problem, I want to interact with an automated chat bot to specify my issue category, narrow down the specific order problem, and select the affected order from my purchase history, so that my support inquiry is properly categorized and contextualized before connecting to a live human agent.

**Why this priority**: Without issue triage and order selection, support inquiries lack context, preventing the agent from reviewing the relevant order details and delaying resolution. This is the initial entry point of the entire support journey.

**Independent Test**: Can be tested independently by navigating to `/chat`, verifying the bot greeting message, selecting issue options across the 3 step-by-step triage screens (68, 69, 70), selecting an order card from purchase history, navigating backward/forward with Back and Next buttons, and confirming transition to agent connection.

**Acceptance Scenarios**:

1. **Given** an authenticated user navigating to `/chat`, **When** the page renders Screen 68, **Then** they see:
   - A top header displaying the Chat Bot circular logo, bold title `Chat Bot`, subtitle `Customer Care Service`, and a circular `✕` close button on the right.
   - A full-height vertical gradient background transitioning smoothly from light blue at the top, to white in the middle, and light blue at the bottom.
   - An initial bot welcome message in a left-aligned light grey bubble: *"Hello, Amanda! Welcome to Customer Care Service. We will be happy to help you. Please, provide us more details about your issue before we can start."* with a timestamp below.
   - A question heading `What's your issue?`.
   - Five vertical selectable issue chips: `Order Issues` (selected by default with blue background and checkmark), `Item Quality`, `Payment Issues`, `Technical Assistance`, and `Other` (unselected with white background and blue outline).
   - A full-width primary `Next` button at the bottom.
2. **Given** the user on Screen 68, **When** they tap any issue chip (e.g., `Item Quality` or `Payment Issues`), **Then** that chip becomes selected with active styling while previously selected chips revert to unselected styling.
3. **Given** `Order Issues` is selected on Screen 68, **When** the user taps `Next`, **Then** the view transitions to Screen 69 (*Order Issues*).
4. **Given** Screen 69 (*Order Issues*), **When** rendered, **Then** they see:
   - The same header and chat background.
   - The question heading `Order Issues`.
   - Five vertical sub-issue chips: `I didn't receive my order` (selected by default), `I want to cancel my order`, `I want to return my order`, `Package was damages`, and `Other`.
   - A bottom navigation bar containing a circular grey back arrow button on the left and a blue `Next` button on the right.
5. **Given** Screen 69, **When** the user taps the circular back button, **Then** the screen navigates back to Screen 68 with the previously chosen selection preserved.
6. **Given** Screen 69, **When** the user selects a sub-issue and taps `Next`, **Then** the view transitions to Screen 70 (*Select your Order*).
7. **Given** Screen 70 (*Select your Order*), **When** rendered, **Then** they see:
   - The question heading `Select your Order`.
   - Compact order summary cards representing recent orders, each displaying product thumbnails, order number (e.g., `#655541`), delivery method pill (`Standard Delivery`), item count pill (`4 items`), order status (`Shipped` or `Delivered`), and an action pill button (`Select` in blue or `Selected` in grey).
   - The bottom navigation bar with the back arrow and `Next` button.
8. **Given** Screen 70, **When** the user taps `Select` on an order card, **Then** that order becomes highlighted with `Selected` status, and previous selections are deselected.
9. **Given** an order is selected on Screen 70, **When** the user taps `Next`, **Then** the bot triage flow completes and initiates the agent connection phase (Screen 71).

---

### User Story 2 - Agent Connection Handshake & Greeting (Screens 71, 72, 73, 74) (Priority: P2)

As a customer who completed bot triage, I want the chat to seamlessly connect me to a human support representative, display the conversation history (including my selected issue and order), and provide clear typing status indicators, so that I know a real person is reviewing my case and preparing a response.

**Why this priority**: The agent connection handshake bridges automated triage and human assistance. Visual indicators (connecting state, typing dots, agent identity) reassure the user that their issue is actively handled.

**Independent Test**: Can be tested independently by completing bot triage or entering agent chat state, observing the 3 animated dots on Screen 71 ("Connecting with an Agent"), observing the header transition to agent Maggie Lee with animated typing dots on Screen 72, seeing the agent greeting message on Screen 73, and receiving the order status update on Screen 74.

**Acceptance Scenarios**:

1. **Given** completion of bot triage, **When** Screen 71 (*Connecting with an Agent*) renders, **Then**:
   - The header displays the Chat Bot logo and "Customer Care Service".
   - The message history reflects the user's previous choices as messages: bot questions, user response pills (`Order Issues`, `I didn't receive my order`), and the selected compact order card embedded inline in the message list.
   - A status bubble appears: *"Connecting with an Agent"* accompanied by 3 animated pulsating dots.
   - The bottom message input field is present but visually disabled during connection.
2. **Given** Screen 71, **When** the connection completes (~2 seconds simulated delay), **Then** the view automatically transitions to Screen 72 (*Agent is Typing*).
3. **Given** Screen 72 (*Agent is Typing*), **When** rendered, **Then**:
   - The header transitions to the assigned agent: circular photo avatar of Maggie Lee, bold title `Maggie Lee`, subtitle `Customer Care Service`, and the circular `✕` close button.
   - An agent typing indicator bubble appears in the message stream showing *"Typing..."* with 3 animated dots.
4. **Given** Screen 72, **When** the typing simulation finishes (~2 seconds delay), **Then** the view transitions to Screen 73 (*Chat Hello*):
   - The agent's first message appears in a left-aligned blue bubble with white text: *"Hello, Amanda! I'm Maggy, your personal assistant from Customer Care Service. Let me go through your order and check its current status. Wait a moment please."* with timestamp below.
   - The bottom input area becomes fully active, allowing user typing, with Camera and Document utility icons alongside the text field.
5. **Given** Screen 73, **When** the user sends a reply (e.g., *"Hello, Maggy! Sure!"*), **Then** the user's message appears in a right-aligned blue bubble.
6. **Given** Screen 74 (*Chat Response*), **When** the agent responds, **Then** two consecutive left-aligned blue bubbles appear:
   - Bubble 1: *"Thank you for waiting Amanda! I just checked your order status and seems like there was a problem on our end. We are really sorry about that. You will receive your parcel within 2 days."*
   - Bubble 2: *"We would like to give you a small gift. 15% off for your next purchase."*

---

### User Story 3 - In-Chat Voucher Compensation & Fluid Conversation (Screens 75, 76, 77, 78, 79) (Priority: P3)

As a customer receiving customer care compensation, I want a discount voucher card rendered directly within the chat timeline, and I want an interactive message list with smart scrolling assistance, so that I can conveniently review my compensation and continue chatting smoothly.

**Why this priority**: Embedding rich interactive widgets (VoucherCard, compact OrderCard) directly into the message timeline creates an engaging, modern customer experience that bridges chat with commerce rewards.

**Independent Test**: Can be tested independently by progressing to Screen 75, confirming that the 15% discount VoucherCard displays inline with rounded corners, side notches, and dashed divider, sending conversational messages ("Wow! Thanks a lot, Maggy!"), scrolling up to verify the circular "Scroll to Bottom" button appears (Screen 78), tapping it to return to bottom, and completing the conversation (Screen 79).

**Acceptance Scenarios**:

1. **Given** the agent's compensation offer on Screen 75, **When** the message stream renders, **Then** an inline ticket-style **VoucherCard** appears immediately below the agent's gift message:
   - Displays header: `Voucher` on left and red expiration date `Valid Until 5.16.20` on right.
   - Displays dashed horizontal divider line between side concave circular cutouts.
   - Displays circular badge icon, bold title `From Customer Care`, and discount description `15% off your next purchase`.
   - Styled with a solid blue border matching the existing Rewards/Profile design token standards.
2. **Given** Screen 75, **When** the user taps the embedded VoucherCard, **Then** the app provides feedback acknowledging voucher details (or opens a voucher preview dialog).
3. **Given** Screen 76 (*Chat Messaging 1*), **When** the user types and sends *"Wow! Thanks a lot, Maggy!"*, **Then** it appears as a right-aligned blue bubble with timestamp.
4. **Given** Screen 77 (*Chat Messaging 2*), **When** the agent asks *"Is there anything else I can help you with?"* and user replies *"Nope, all good"*, **Then** both messages appear in chronological order.
5. **Given** Screen 78 (*Scroll to Bottom*), **When** the user scrolls up past recent messages, **Then** a floating circular blue button with a white downward arrow appears in the bottom-right corner of the message area.
6. **Given** the visible scroll-to-bottom button on Screen 78, **When** tapped, **Then** the message list smoothly scrolls down to the latest message and the floating button disappears.
7. **Given** Screen 79 (*Chat Messaging 3*), **When** the agent sends the closing message *"Great! Have a nice day! Was happy to help you."*, **Then** the conversation is marked resolved.

---

### User Story 4 - Customer Care Rating & Feedback Review Modal (Screen 80) (Priority: P4)

As a customer who has concluded a support session, I want to rate the quality of service provided by the agent using an interactive star rating and written comments in a clean modal dialog, so that I can express my satisfaction and help improve customer service.

**Why this priority**: Feedback collection is crucial for customer care quality control and closes the support lifecycle gracefully.

**Independent Test**: Can be tested independently by triggering chat closure (tapping the top-right `✕` close button or closing the conversation on Screen 79), confirming that the review modal sheet slides up with agent Maggie Lee's info, selecting 1-5 stars, typing a comment, tapping `Send Review`, and verifying successful submission and return navigation to Profile.

**Acceptance Scenarios**:

1. **Given** an active or completed chat, **When** the user taps the top-right circular `✕` close button or finishes the chat flow, **Then** the Customer Care Review modal sheet (Screen 80) is presented.
2. **Given** Screen 80 (*Customer Care Review* modal), **When** rendered, **Then** it displays:
   - A modal container with rounded top corners.
   - A header row with bold title `Rate our Service` and a circular `✕` close button.
   - Agent profile row: Maggie Lee photo avatar, bold title `Maggie Lee`, and subtitle `Customer Care Service`.
   - Five large tappable rating stars, defaulting to an unrated outlined state (grey outline) and turning solid gold upon selection.
   - A multi-line comment input box with light blue background and placeholder text `Your comment`.
   - A full-width primary button `Send Review`.
3. **Given** the 5 stars on Screen 80, **When** the user taps the 4th star, **Then** stars 1 through 4 illuminate in solid gold while the 5th star remains outlined.
4. **Given** the comment input on Screen 80, **When** the user enters feedback text, **Then** the comment state updates cleanly without lag.
5. **Given** a selected star rating on Screen 80, **When** the user taps `Send Review`, **Then** the review is submitted, a confirmation feedback indicator is shown, the modal closes, and the app navigates back to the Profile screen (`/profile`).
6. **Given** the user on Screen 80, **When** they tap the modal's `✕` close button without submitting, **Then** the modal dismisses and navigates back to the Profile screen without submitting review data.

---

### Edge Cases

- **Fast Backward Navigation in Bot Triage**: If the user navigates back from Screen 70 to 69 to 68 and changes their selection, the previously downstream selections (e.g. selected order or sub-issue) are cleanly reset or reconciled with the new branch.
- **Connection Interruption / Timeout**: If agent connection cannot establish within the timeout window, the system displays a retry prompt in the chat bubble rather than crashing or freezing.
- **Keyboard Handling & Overflow**: When typing in the message input field or the review comment box, the keyboard smoothly pushes the content without viewport overflow errors (`ResizeToAvoidBottomInset: true`).
- **Rapid Message Dispatch**: Tapping the send button rapidly does not duplicate messages in the chat stream; messages are debounced and processed sequentially.
- **Long Message Text & Dynamic Sizing**: Messages with extensive copy or multiline text wrap naturally within standard bubble maximum widths (e.g. 75% of screen width) without horizontal clipping.
- **Empty Message Prevention**: Attempting to send an empty or whitespace-only message is disabled or ignored.
- **Review Modal Dismissal**: Tapping outside the modal (barrier tap) or hardware back button cleanly dismisses the review sheet without leaving orphaned modal state.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST provide an integrated Chat feature mounted at `/chat`, accessible from the Profile screen and other customer service entry points.
- **FR-002**: The system MUST render all chat screens (68–79) inside a unified `ChatPage` layout featuring a vertical light-blue-to-white gradient background, top header, scrollable message list, and adaptive bottom action area.
- **FR-003**: The system MUST render the top `ChatHeader` with:
  - Bot logo avatar and title `Chat Bot` during Screens 68–71.
  - Agent photo avatar and title `Maggie Lee` during Screens 72–79.
  - Constant subtitle `Customer Care Service` and circular `✕` close action button across all chat screens.
- **FR-004**: The system MUST execute the 3-step Chat Bot triage flow:
  - Screen 68: Question `What's your issue?` with 5 vertical selectable chips (`Order Issues`, `Item Quality`, `Payment Issues`, `Technical Assistance`, `Other`) and a full-width `Next` button.
  - Screen 69: Question `Order Issues` with 5 selectable sub-issue chips (`I didn't receive my order`, `I want to cancel my order`, `I want to return my order`, `Package was damages`, `Other`), circular back button, and `Next` button.
  - Screen 70: Question `Select your Order` displaying compact order cards with item thumbnails, order number, delivery type, item count, `Select`/`Selected` toggle pill, circular back button, and `Next` button.
- **FR-005**: The system MUST visually distinguish active/selected chips (primary blue background with white text and checkmark) from inactive chips (white background, blue border, primary blue text).
- **FR-006**: The system MUST support seamless transition to Agent Connection on Screen 71, displaying previous user selections and the selected compact order card as inline chat messages, an animated 3-dot "Connecting with an Agent" indicator, and a disabled input field.
- **FR-007**: The system MUST simulate the human agent connection:
  - Transitioning to Screen 72 with agent identity (Maggie Lee) and an animated 3-dot "Typing..." bubble.
  - Transitioning to Screen 73 with agent greeting bubble and enabling the interactive bottom input field.
  - Transitioning to Screen 74 with agent explanation regarding order status and compensation offer.
- **FR-008**: The system MUST render message bubbles with strict visual distinction:
  - Bot messages: light grey background (`AppColors.surfaceContainer` / `botBubbleBg`), dark text, left-aligned.
  - User messages: primary blue background (`AppColors.primary`), white text, right-aligned.
  - Agent messages: primary blue background (`AppColors.primary`), white text, left-aligned.
  - Message timestamps rendered in secondary grey typography below each bubble.
- **FR-009**: The system MUST embed rich widgets inline within the scrollable message stream:
  - Compact `ChatOrderCard` displaying order summary (Screens 71–79).
  - Ticket-notched `VoucherCard` displaying 15% discount compensation with dashed cut line and red expiration date (Screen 75).
- **FR-010**: The system MUST provide an interactive bottom message input bar for Screens 73–79, including a multiline-capable text field with placeholder `Message`, Camera icon button, Document icon button, and Send message trigger.
- **FR-011**: The system MUST display a floating circular blue "Scroll to Bottom" button with a white down arrow in the bottom-right corner when the user scrolls up in the chat timeline (Screen 78), which scrolls to the latest message and hides upon tap.
- **FR-012**: The system MUST present the Customer Care Review modal (Screen 80) upon chat closure or review trigger, featuring:
  - Top header with `Rate our Service` title and `✕` close button.
  - Agent summary with Maggie Lee photo avatar, name, and `Customer Care Service` subtitle.
  - Five tappable interactive rating stars (grey outline when unselected, solid gold `#FFAE00` when selected).
  - Multi-line comment input area with light blue tint background and placeholder `Your comment`.
  - Full-width primary button `Send Review`.
- **FR-013**: The system MUST submit review data upon tapping `Send Review` and navigate back to the Profile screen (`/profile`).
- **FR-014**: The system MUST strictly adhere to the DRY principle by reusing existing widgets:
  - `PrimaryButton` from `lib/shared/widgets/primary_button.dart` for Next, Select, and Send Review.
  - `VoucherCard` from `lib/features/profile/presentation/widgets/voucher_card.dart` for inline compensation vouchers.
  - `MetaPill` from `lib/shared/widgets/meta_pill.dart` for compact order metadata tags.
  - `AppText` from `lib/shared/widgets/app_text.dart` for all headings and text blocks.
  - `AppContainer` from `lib/shared/widgets/app_container.dart` for structured card containers.
  - Star rating pattern from `lib/features/product/presentation/widgets/review_card.dart`.
- **FR-015**: The system MUST strictly enforce design tokens (`AppColors`, `AppSpacing`, `AppTypography`) with zero hardcoded colors or dimension numbers (Rule #11). Missing tokens for chat backgrounds, bot bubbles, chips, and typing dots MUST be added to `lib/core/theme/app_colors.dart` prior to use.
- **FR-016**: The system MUST NOT generate any new image or icon files (Rule #2). Existing assets in `assets/images/` and `assets/design_references/` MUST be reused for avatars and icons; the vertical gradient background MUST be constructed via Flutter CSS-like `BoxDecoration` without background images.

---

### Key Entities

- **`ChatMessageEntity`**: Represents an individual message in the chat timeline, containing unique identifier (`id`), sender role (`ChatMessageSender`: `bot`, `user`, `agent`), message text (`text`), delivery timestamp (`timestamp`), and optional attached entity payload (`ChatAttachmentEntity?`).
- **`ChatAttachmentEntity`**: Represents rich media or domain entities embedded within a chat bubble, containing attachment type (`ChatAttachmentType`: `order`, `voucher`) and payload data (e.g. order identifier, order details, voucher code, discount amount).
- **`ChatBotOptionEntity`**: Represents a selectable triage choice in Screens 68 and 69, containing option identifier (`id`), label text (`title`), and active selection status (`isSelected`).
- **`ChatAgentEntity`**: Represents the customer care support representative, containing identifier (`id`), display name (`name`, e.g. "Maggie Lee"), avatar image asset path (`avatarUrl`), and role title (`role`, e.g. "Customer Care Service").
- **`ChatReviewEntity`**: Represents customer satisfaction feedback, containing review identifier (`id`), agent identifier (`agentId`), star rating score (`rating`: 1–5), optional user feedback comment (`comment`), and submission timestamp (`submittedAt`).
- **`ChatOrderSummaryEntity`**: Represents the compact order information displayed during triage and embedded in chat history, containing order number (`orderNumber`), status (`status`: `shipped`, `delivered`), delivery type (`deliveryType`), item count (`itemCount`), and thumbnail asset path (`thumbnailUrl`).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% visual fidelity matching Figma reference screenshots (68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80) in colors, typography, spacing, corner radii, and icon sizes.
- **SC-002**: Smooth transition across the 3 bot triage steps (Screens 68, 69, 70) with instant chip selection response (<50ms).
- **SC-003**: Seamless agent connection and typing state simulation transitioning from bot to agent within realistic simulated delays (1.5–2.5 seconds per phase).
- **SC-004**: Interactive message list supports instant user message appending and automatic scrolling down to the newest message upon dispatch.
- **SC-005**: Floating "Scroll to Bottom" button appears reliably when user scrolls up by more than 150dp and smoothly returns to the bottom on tap within 300ms.
- **SC-006**: Embedded `VoucherCard` (Screen 75) and `ChatOrderCard` render with 100% architectural reuse of existing components without layout breakage.
- **SC-007**: Interactive 5-star rating on Screen 80 updates visually on tap with zero input latency (<16ms frame budget).
- **SC-008**: 100% compliance with design tokens: zero hardcoded color hex values, zero hardcoded spacing dimensions, and zero hardcoded text styles.
- **SC-009**: Zero new image or icon files created; all assets reuse existing project files.
- **SC-010**: Flutter static analysis (`fvm flutter analyze`) passes with 0 errors and 0 warnings.

---

## Assumptions

- Target user is authenticated (e.g. "Amanda" / "Romina") with active mock order history available from the Orders feature.
- Phase 1 scope operates strictly with structured mock data sources for bot triage trees, agent conversation script, and review submission.
- Camera and Document utility icons on the chat input bar display informative SnackBar placeholders during Phase 1.
- Navigation to `/chat` can be triggered from Profile or direct route, and closing the chat or submitting a review returns the user to the previous screen or `/profile`.
- Layout dimensions are responsively scaled using `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`).

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
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

