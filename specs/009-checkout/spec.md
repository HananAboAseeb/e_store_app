# Feature Specification: Checkout (Screens 47, 48, 49, 50)

**Feature Branch**: `feature/checkout`

**Created**: 2026-09-24

**Status**: Draft

**Input**: User specification and Figma design reference screenshots for Screen 47 (Payment / Checkout Summary), Screen 48 (Add Voucher Bottom Sheet), Screen 49 (Voucher Added Summary), and Screen 50 (Edit Shipping Address Bottom Sheet). Part 2 of the 3-part Cart & Checkout experience (Cart: Screens 44–46, Checkout: Screens 47–50, Payment: Screens 51–56). Provides complete order preparation including delivery destination display, contact information, order item summary, interactive voucher application/removal with reactive discount recalculation, shipping method selection, and seamless transition to payment.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Checkout Order Review & Summary (Screen 47) (Priority: P1)

As a shopper proceeding from the cart, I want to review my complete order summary—including delivery address, contact details, item details, shipping method, and total amount—so that I can verify all order information before proceeding to payment.

**Why this priority**: Essential checkout foundation. Customers must be able to review their shipping destination, contact info, item breakdown, and shipping method before committing financial transactions.

**Independent Test**: Navigate to `/checkout`. Verify the app bar renders "Payment" with a circular close button (`✕`). Verify the Shipping Address card displays "Shipping Address", the current address lines, and a blue circular edit button. Verify the Contact Information card displays "Contact Information", phone number, email, and a blue circular edit button. Verify the Items section displays "Items" with a count badge (`2`), an outlined "Add Voucher" button, and two item cards with thumbnail photos, titles, quantity circle badges (`1`), variant pills (`Pink`, `M`), and item prices (`$17,00`). Verify the Shipping Options section displays "Standard" selected ($3.00) and "Express" ($12.00) with estimated delivery date. Verify the sticky bottom bar shows the calculated total (`$34.00`) and a black pill "Pay" button.

**Acceptance Scenarios**:

1. **Given** a customer navigates from cart to `/checkout`, **When** the screen renders, **Then** the header displays "Payment" with a circular `✕` button to exit checkout.
2. **Given** the Shipping Address card on Screen 47, **When** displayed, **Then** it presents the title "Shipping Address", formatted address text ("United States, New York, NY / 110 W 44th Street, New York, NY 10036"), and a blue circular button with a white pencil edit icon.
3. **Given** the Contact Information card, **When** displayed, **Then** it shows the title "Contact Information", telephone ("+1-866-922-8694"), email ("design.blackside@gmail.com"), and a blue circular edit button.
4. **Given** the Items section header, **When** rendered, **Then** it shows the label "Items", a count badge circle showing `2`, and an outlined blue pill button labeled "Add Voucher".
5. **Given** each order item card, **When** rendered, **Then** it displays a rounded product photo, a 2-line title, a solid blue circular badge with the item quantity (`1`), variant pills for color (`Pink`) and size (`M`), and the bold price (`$17,00`).
6. **Given** the sticky bottom bar on Screen 47, **When** displayed, **Then** the left side shows `Total: $34.00` and the right side displays a black pill button labeled "Pay".

---

### User Story 2 - Applying Active Vouchers & Discount Calculation (Screen 48 & Screen 49) (Priority: P2)

As a shopper with available promotional discounts, I want to open the active vouchers sheet and apply a voucher, so that a discount is applied to my order total and clearly indicated on the checkout summary.

**Why this priority**: Directly drives conversion and customer satisfaction by enabling coupon/voucher code discounts during order finalization.

**Independent Test**: On Screen 47, tap the "Add Voucher" button. Verify Screen 48 (modal bottom sheet) slides up with title "Active Vouchers" and a circular `✕` button. Verify active voucher cards are displayed with ticket cutouts, dashed divider lines, validity dates, titles ("From Customer Care", "First Purchase"), discount descriptions ("15% off your next purchase", "5% off for your next order"), and blue "Apply" buttons. Tap "Apply" on the "First Purchase" (5%) voucher. Verify the bottom sheet dismisses, the "Add Voucher" button on the summary is replaced by a solid blue badge reading `5% Discount ✕` (Screen 49), and the total price updates reactively to reflect the applied discount.

**Acceptance Scenarios**:

1. **Given** Screen 47 (Checkout Summary), **When** the customer taps "Add Voucher", **Then** the modal bottom sheet Screen 48 opens with top rounded corners (`24.r`).
2. **Given** Screen 48 (Active Vouchers), **When** rendered, **Then** it displays header "Active Vouchers", a circular `✕` dismiss button, and available voucher ticket cards.
3. **Given** a voucher ticket card on Screen 48, **When** rendered, **Then** it displays a stylized ticket container with side cutouts, dashed blue divider, validity expiration date in red/orange ("Valid Until 5.16.20" / "Valid Until 6.20.20"), voucher title, discount text, and a blue "Apply" button.
4. **Given** the active voucher list, **When** the customer taps "Apply" on a voucher (e.g., 5% First Purchase), **Then** the bottom sheet closes immediately, the applied voucher is registered in checkout state, and Screen 49 is displayed.
5. **Given** Screen 49, **When** rendered after voucher application, **Then** the "Add Voucher" button is replaced by a solid blue pill badge displaying `5% Discount ✕`, and the total price is recalculated.

---

### User Story 3 - Voucher Removal & Reversion (Screen 49) (Priority: P3)

As a shopper who has applied a voucher, I want to remove the voucher by tapping the `✕` on the discount badge, so that I can cancel the discount or choose a different promotion.

**Why this priority**: Ensures user control and transparency over discounts and order amounts.

**Independent Test**: On Screen 49 with an active voucher badge (`5% Discount ✕`), tap the `✕` button on the badge. Verify the voucher badge is removed, the button returns to the blue-outlined "Add Voucher" pill (Screen 47), and the order total recalculates back to the original price without the discount.

**Acceptance Scenarios**:

1. **Given** Screen 49 with an applied voucher badge (`5% Discount ✕`), **When** the customer taps the `✕` icon, **Then** the voucher is immediately removed from the checkout session.
2. **Given** voucher removal, **When** processed, **Then** the header action reverts back to the outlined "Add Voucher" pill button, and the total order price recalculates reactively.

---

### User Story 4 - Editing Shipping Destination Address (Screen 50) (Priority: P4)

As a shopper who needs their items delivered to a specific address, I want to edit my shipping address via a dedicated bottom sheet, so that my order is delivered to the correct destination.

**Why this priority**: Essential fulfillment requirement. Shoppers must be able to verify and modify destination country, street address, city, and postal code.

**Independent Test**: On Screen 47 or Screen 49, tap the circular blue edit button on the Shipping Address card. Verify Screen 50 slides up as a modal bottom sheet with title "Shipping Address" and a circular `✕` button. Verify input fields for Country ("Iran" or dynamic country with info icon), Address ("110 W 44th Street, NY 10036"), Town / City ("New York"), and Postcode ("10012") are displayed with light blue input backgrounds. Modify the street address or city. Tap `✕` or close the sheet. Verify the Shipping Address card on Screen 47/49 updates with the new address details.

**Acceptance Scenarios**:

1. **Given** Screen 47 or Screen 49, **When** the customer taps the blue edit button on the Shipping Address card, **Then** modal bottom sheet Screen 50 opens with header "Shipping Address" and a circular `✕` button.
2. **Given** Screen 50 (Edit Shipping Address), **When** rendered, **Then** it presents Country (with dropdown/info indicator), Address text field, Town / City text field, and Postcode text field.
3. **Given** the input fields on Screen 50, **When** displayed, **Then** each text field has a rounded shape, light blue background tint, and pre-populated values from the current address.
4. **Given** the customer edits one or more address fields, **When** the bottom sheet is closed, **Then** the updated address is persisted in the checkout session and reflected on the summary card.

---

### User Story 5 - Shipping Option Selection & Delivery Estimate (Priority: P5)

As a shopper, I want to choose between standard and express shipping options with clear delivery timetables and pricing, so that I can balance delivery speed and cost according to my needs.

**Why this priority**: Directly impacts order total and delivery expectations.

**Independent Test**: On Screen 47, inspect the "Shipping Options" section. Verify "Standard | 5 - 7 Days | $3.00" is selected by default with a blue background and checkmark, while "Express | 1 - 2 Days | $12.00" is unselected with a grey container. Tap "Express". Verify "Express" becomes selected with the active blue styling, "Standard" becomes unselected, and the order total increases by $9.00 ($12.00 vs $3.00 difference). Tap "Standard" again; verify it reverts to standard pricing.

**Acceptance Scenarios**:

1. **Given** the Shipping Options section, **When** rendered, **Then** it displays options for "Standard" (5 - 7 Days, $3.00) and "Express" (1 - 2 Days, $12.00), along with estimated delivery text ("Delivered on or before Thursday, 23 April 2020").
2. **Given** a shipping option container, **When** selected, **Then** it displays a light blue container background, blue checkmark indicator, and bold price.
3. **Given** a shipping option container, **When** unselected, **Then** it displays a light grey background and an empty circular radio indicator.
4. **Given** the customer selects an alternative shipping option, **When** tapped, **Then** the selection toggles reactively, and the order total is updated to reflect the new shipping fee.

---

### User Story 6 - Payment Method Preview & Transition to Payment (Priority: P6)

As a shopper ready to complete payment, I want to review my payment method preference (Card / Paypal) and tap "Pay" to navigate to the payment screen, so that I can finalize payment processing.

**Why this priority**: Connects order preparation with the dedicated payment transaction workflow (Screens 51–56).

**Independent Test**: On Screen 47 or Screen 49, inspect the "Payment Method" section. Verify the selection chips for `Card` (selected) and `Paypal` (unselected) are displayed as a visual preview. Tap the sticky bottom bar "Pay" button. Verify the application initiates navigation to the `/payment` route.

**Acceptance Scenarios**:

1. **Given** the Payment Method section, **When** rendered, **Then** it displays selection chips for `Card` and `Paypal`.
2. **Given** the sticky bottom bar with "Pay", **When** the customer taps "Pay", **Then** the application navigates to `/payment`.
3. **Given** the header close button (`✕`), **When** tapped, **Then** the application navigates back to the cart (`/cart`).

---

### Edge Cases

- **Voucher Stacking**: Only one voucher may be applied at any given time. Applying a new voucher replaces any previously applied voucher.
- **Voucher Removal Recalculation**: Removing an applied voucher immediately recalculates the subtotal, resets the discount to $0.00, and restores the base price plus shipping fee.
- **Empty Address Submission**: If any required field in Screen 50 (Address, Town / City, Postcode) is completely cleared, validation preserves the previous valid address or falls back to default values to prevent blank address cards.
- **Long Address Text Truncation**: When the shipping address string is exceptionally long, the address card text truncates cleanly with ellipsis to preserve visual balance.
- **Shipping Option Toggling**: Rapid toggling between Standard and Express shipping updates the total price cleanly without animation lag or calculation anomalies.
- **Total Calculation Formula**: Total is strictly defined as `(Items Subtotal - Voucher Discount) + Shipping Fee`.
- **Payment Method Placeholder Isolation**: Payment method selection on Screen 47 is an interactive visual preview; full payment integration (Stripe, PayPal, card inputs) is strictly isolated to the downstream `payment` feature module.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display an app bar titled "Payment" with a circular `✕` button that returns to `/cart`.
- **FR-002**: System MUST render a Shipping Address card displaying the delivery destination and a blue circular edit button.
- **FR-003**: System MUST open the modal bottom sheet Screen 50 when the Shipping Address edit button is tapped.
- **FR-004**: System MUST render editable fields on Screen 50 for Country, Address, Town / City, and Postcode, pre-populated with current address data.
- **FR-005**: System MUST persist and update the Shipping Address on the summary card upon closing Screen 50.
- **FR-006**: System MUST render a Contact Information card displaying phone number, email address, and an edit button.
- **FR-007**: System MUST render an Items section with the section title "Items", a count badge circle showing item quantity, and voucher action button.
- **FR-008**: System MUST render each checkout item card with product thumbnail, 2-line title, quantity indicator circle, color pill, size pill, and item price.
- **FR-009**: System MUST display the "Add Voucher" button when no voucher is applied, and open Screen 48 (Active Vouchers) upon tapping.
- **FR-010**: System MUST render available active vouchers in Screen 48 with ticket cutout borders, dashed dividers, expiration dates, discount amounts, and "Apply" buttons.
- **FR-011**: System MUST apply the selected voucher upon tapping "Apply", dismiss Screen 48, replace "Add Voucher" with a blue discount pill badge (`5% Discount ✕` on Screen 49), and recalculate the total.
- **FR-012**: System MUST remove the applied voucher when the `✕` on the discount pill badge is tapped, reverting the button back to "Add Voucher" and restoring the undiscounted total.
- **FR-013**: System MUST display shipping options ("Standard" 5-7 Days $3.00, "Express" 1-2 Days $12.00) with dynamic delivery date text.
- **FR-014**: System MUST allow selecting between shipping options, highlighting the selected option in active blue and recalculating the total.
- **FR-015**: System MUST render payment method preview chips (`Card`, `Paypal`) with single-selection capability.
- **FR-016**: System MUST render a sticky bottom bar displaying `Total:` with the formatted price and a black pill "Pay" button.
- **FR-017**: System MUST navigate to `/payment` when the "Pay" button is tapped.
- **FR-018**: System MUST render shimmer loading placeholders during initial checkout summary retrieval.

---

### Key Entities *(include if feature involves data)*

- **CheckoutSummaryEntity**: Complete order checkout state containing `id` (String), `shippingAddress` (ShippingAddressEntity), `contactInfo` (ContactInfoEntity), `items` (List<OrderItemEntity>), `shippingOptions` (List<ShippingOptionEntity>), `selectedShippingOption` (ShippingOptionEntity), `appliedVoucher` (VoucherEntity?), `subtotal` (double), `shippingFee` (double), `discountAmount` (double), and `total` (double).
- **VoucherEntity**: Promotional voucher representation containing `id` (String), `title` (String, e.g., "First Purchase"), `description` (String, e.g., "5% off for your next order"), `discountPercentage` (double, e.g., 5.0 or 15.0), `validUntil` (String, e.g., "6.20.20"), `code` (String), and `iconType` (String / enum: customerCare, firstPurchase).
- **ShippingAddressEntity**: Delivery address details containing `id` (String), `country` (String), `street` (String), `city` (String), `zipCode` (String), and `formattedAddress` (String).
- **ContactInfoEntity**: Customer contact data containing `id` (String), `phone` (String), and `email` (String).
- **ShippingOptionEntity**: Delivery method containing `id` (String), `name` (String, e.g., "Standard"), `duration` (String, e.g., "5 - 7 Days"), `price` (double, e.g., 3.00), and `estimatedDate` (String).
- **OrderItemEntity**: Snapshot of an item ready for checkout containing `id` (String), `productId` (String), `title` (String), `imageUrl` (String), `quantity` (int), `size` (String), `color` (String), and `unitPrice` (double).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Customers can review order details, apply a voucher, and tap "Pay" in under 20 seconds.
- **SC-002**: 100% of voucher applications and removals update the discount badge and total price reactively with zero lag (< 100ms).
- **SC-003**: 100% of shipping option switches immediately recalculate the order total and adjust delivery estimates.
- **SC-004**: Address modifications in Screen 50 persist to the summary screen immediately upon dismissal.
- **SC-005**: Zero layout overflow errors across small, standard, and large mobile device screen viewports.
- **SC-006**: 100% pixel-perfect compliance with Figma design references `47 PAYMENT.png`, `48 ADD VOUCHER.png`, `49 VOUCCHER ADDED.png`, and `50 EDIT SHIPPING ADDRESS.png`.

---

## Assumptions

- **Mock Data Scope**: In Phase 1, checkout summary data, active vouchers list, default address, and contact info are provided by a structured mock data source with in-memory state mutations.
- **Voucher Calculation**: Discounts are calculated as a percentage of the items subtotal (`subtotal * (discountPercentage / 100)`). Shipping fee is added after the discount is applied.
- **Address Edit Persistence**: Dismissing or closing the Screen 50 bottom sheet commits the currently entered form values to the checkout in-memory session.
- **Downstream Route**: The "Pay" button triggers navigation to `/payment`. The dedicated payment screens (Screens 51–56) will be fully implemented in the future `payment` feature module.
- **Component Reuse**: Existing shared widgets (`PrimaryButton`, `DiscountBadge`, `ShopProductCard`) will be leveraged where applicable.
- **Design Token Strictness**: All colors, dimensions, and typography reference design tokens from `AppColors`, `AppSpacing`, and `AppTypography` exclusively.

---

## Permanent Project Rules Reference

All features MUST strictly comply with the Permanent Project Rules defined in the project Constitution (`.specify/memory/constitution.md`):
1. **Verification Timing**: Do NOT run `flutter analyze` or `flutter test` after each individual task. Save all static analysis and verification strictly for the final phase to save tokens and time.
2. **Asset Policy**: Do NOT generate any new placeholder images, icons, or asset files. Reuse existing assets located in `assets/images/` and `assets/design_references/` only. Use provided Figma screenshots strictly as visual references.
3. **Architectural Adherence**: STRICTLY adhere to the project Constitution, Feature-First Clean Architecture, Design Tokens (`app_colors`, `app_spacing`, `app_typography`, `app_theme`), and all established coding standards.
4. **Code Quality & Design Patterns**: Write clean, production-ready Dart code using proper Design Patterns (Repository, UseCase, Cubit/Bloc, Factory for models, etc.). Extract all reusable UI components into separate widget files.
5. **Dimensions & Frameworks**: All dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). All navigation must use `go_router`. All state management must use `flutter_bloc` (Cubit) with `equatable` states.
6. **Component Reuse**: Reuse existing shared widgets and components from previous features (e.g., DiscountBadge, ShopProductCard, PrimaryButton, etc.) whenever applicable.
7. **Clean Architecture Layers**: Every feature must include: Domain (entities, repository contract, usecases), Data (models, mock datasource, repository impl with `safeCall`), Presentation (cubit, state, pages, widgets), DI registration, and routing.
8. **Phase 1 Data Scope**: Mock Data only in Phase 1 (no real API).
9. **Loading Experience**: Shimmer placeholders for all loading states.
10. **Visual Perfection**: Pixel-perfect match with the Figma screenshots (colors, spacing, radius, typography).
11. **STRICT COLOR & TOKEN ENFORCEMENT**: All colors, spacing, and typography must reference tokens from `AppColors`, `AppSpacing`, and `AppTypography`. No hardcoded values are allowed. If a token is missing, add it to the tokens file first.
