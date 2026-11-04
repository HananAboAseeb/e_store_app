# Quickstart Validation Guide: Customer Care Support & Interactive Chat (Screens 68–80)

**Feature**: `specs/014-chat`  
**Date**: 2026-11-02  
**Status**: Ready for Validation  

---

## Prerequisites

- Flutter environment configured with FVM (Flutter 3.24.5 / Dart 3.5.4).
- Dependencies installed (`fvm flutter pub get`).
- Application running on mobile device or emulator (`fvm flutter run`).

---

## Validation Scenarios

### Scenario 1: Bot Triage Flow (Screens 68–70)
1. Launch app and navigate to `/chat` (via Profile Chat action button or direct router push).
2. **Screen 68**:
   - Verify `ChatHeader` renders with Bot logo, title `Chat Bot`, subtitle `Customer Care Service`, and close `✕` button.
   - Verify vertical gradient background (light blue top → white center → light blue bottom).
   - Verify welcome bubble: *"Hello, Amanda! Welcome to Customer Care Service..."*.
   - Verify `Order Issues` is selected with blue fill and checkmark.
   - Tap `Item Quality` → verify active chip styling shifts. Tap `Order Issues` → verify re-selection.
   - Tap `Next`.
3. **Screen 69**:
   - Verify question changes to `Order Issues`.
   - Verify sub-issue chips render (`I didn't receive my order`, `I want to cancel...`, etc.).
   - Tap circular Back button → verify return to Screen 68.
   - Tap `Next` from Screen 69.
4. **Screen 70**:
   - Verify question changes to `Select your Order`.
   - Verify compact order summary cards render with thumbnails, `#655541`, `Standard Delivery`, and `4 items` pills.
   - Tap `Select` on an order → verify button flips to `Selected` with grey fill.
   - Tap `Next`.

**Expected Result**: Smooth transition from triage questions into agent connection.

---

### Scenario 2: Agent Connection Handshake & Greeting (Screens 71–74)
1. **Screen 71**:
   - Verify previous user triage selections and the selected compact order card appear as chat messages.
   - Verify "Connecting with an Agent" bubble with 3 animated pulsating dots.
   - Verify message input bar is visually disabled.
2. **Screen 72**:
   - Observe automatic transition after ~2 seconds.
   - Verify `ChatHeader` smoothly updates to agent avatar (Maggie Lee), title `Maggie Lee`, and `Customer Care Service`.
   - Verify "Typing..." bubble appears with 3 animated dots.
3. **Screen 73**:
   - Observe transition after ~2 seconds: agent first message appears in blue bubble (*"Hello, Amanda! I'm Maggy..."*).
   - Verify bottom input bar becomes active.
4. **Screen 74**:
   - Type message *"Hello, Maggy! Sure!"* and tap Send.
   - Verify user bubble appears in right-aligned blue with timestamp.
   - Verify agent replies in left-aligned blue bubbles with parcel status update and 15% discount gift message.

**Expected Result**: Realistic agent connection, smooth avatar transition, and fluid message exchange.

---

### Scenario 3: In-Chat Voucher Compensation & Smart Scrolling (Screens 75–79)
1. **Screen 75**:
   - Verify inline `VoucherCard` appears directly in the chat timeline below the gift offer.
   - Verify ticket shape with side notch cutouts, dashed cut line, `From Customer Care`, and red `Valid Until 5.16.20` date.
2. **Screen 76 & 77**:
   - Send reply *"Wow! Thanks a lot, Maggy!"*.
   - Receive agent response *"Is there anything else I can help you with?"*.
   - Send reply *"Nope, all good"*.
3. **Screen 78**:
   - Scroll up past older messages.
   - Verify circular blue floating button with white down arrow appears in the bottom right.
   - Tap the button → verify smooth animated scroll back to the latest message and button hides.
4. **Screen 79**:
   - Receive agent wrap-up message *"Great! Have a nice day! Was happy to help you."*.

**Expected Result**: Rich inline voucher display and seamless scroll assistance.

---

### Scenario 4: Customer Care Rating Modal & Feedback Submission (Screen 80)
1. Tap the top-right `✕` close button or conclude the chat.
2. **Screen 80**:
   - Verify modal sheet slides up with rounded top corners (`24.r`).
   - Verify header `Rate our Service` with circular `ModalCloseButton`.
   - Verify agent info row (Maggie Lee avatar, name, role).
   - Verify 5 outline rating stars.
   - Tap the 4th star → verify stars 1 to 4 illuminate in solid gold (`#FFAE00`).
   - Enter text into comment field (e.g., *"Maggy was extremely fast and helpful!"*).
   - Tap `Send Review` button.
3. **Verification**:
   - Verify review submission triggers SnackBar feedback.
   - Verify modal dismisses and the router navigates back to `/profile`.

**Expected Result**: Complete end-to-end support session with clean feedback collection.

