# Feature Specification: Cart (Screens 44, 45, 46)

**Feature Branch**: `feature/cart`

**Created**: 2026-09-23

**Status**: Draft

**Input**: User specification and Figma design reference screenshots for Screen 44 (Cart with Items), Screen 45 (Cart Shown From Wishlist - Empty), and Screen 46 (Cart Shown From Popular - Empty). Part 1 of the 3-part Cart & Checkout experience (Cart: Screens 44–46, Checkout: Screens 47–51, Payment: Screens 52–56). Provides complete cart management including item listings, quantity adjustment, item deletion, shipping address summary, conditional empty cart states with wishlist and popular product recommendations, reactive totals, and seamless checkout entry.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Active Cart Management & Quantity Controls (Screen 44) (Priority: P1)

As a shopper with items in my shopping basket, I want to review my selected items, inspect sizes/colors, adjust quantities, remove unwanted items, and view my shipping address and total price, so that I can manage my order before proceeding to checkout.

**Why this priority**: Core shopping cart utility. Without viewing items, updating quantities, removing items, and verifying totals, customers cannot finalize their basket or complete a purchase.

**Independent Test**: Navigate to the cart screen (`/cart`) with items present. Verify the header shows "Cart" with an item count badge (`2`). Verify the Shipping Address card displays the user's default delivery address with a circular blue navigation arrow (`→`). Verify each cart item displays a thumbnail image, 2-line title, variant pills (`M` size pill, `Pink` color text), price (`$17,00`), decrement button (`⊖`), quantity count (`1`), increment button (`⊕`), and red trash icon. Tap `⊕` to increase quantity to 2 and verify the total price updates reactively from `$34,00` to `$51,00`. Tap `⊖` to decrease quantity back to 1. Tap the red trash icon on an item and verify it is removed from the cart and the header badge decrements. Verify the sticky bottom bar shows the updated `Total:` and an enabled "Checkout" button.

**Acceptance Scenarios**:

1. **Given** the user has items in their cart, **When** they navigate to `/cart`, **Then** the header displays "Cart" with a light blue badge containing the total item count.
2. **Given** the Shipping Address card on Screen 44, **When** rendered, **Then** it presents the title "Shipping Address", the formatted delivery address (`United States, New York, NY / 110 W 44th Street, New York, NY 10036`), and a circular blue arrow button (`→`).
3. **Given** a cart item card, **When** displayed, **Then** it shows the product image rounded at `12.r`, title truncated to 2 lines max, variant pill `M` and color `Pink`, price in bold Raleway typography, quantity control pills (`⊖`, quantity number, `⊕`), and a red trash icon at the top-left of the image.
4. **Given** a cart item with quantity `1`, **When** the user taps `⊕`, **Then** the item quantity increments to `2`, the item total updates, the cart subtotal/total updates, and the header badge updates reactively.
5. **Given** a cart item with quantity `1`, **When** the user taps `⊖`, **Then** the quantity remains at `1` (minimum quantity boundary; does not delete the item).
6. **Given** a cart item, **When** the user taps the red trash icon, **Then** the item is removed from the cart list, the badge count decreases, and the total price recalculates.
7. **Given** the sticky bottom bar on Screen 44, **When** rendered, **Then** the left side displays `Total:` with the formatted price in bold Raleway (e.g., `$34,00`), and the right side displays an enabled Primary 400 blue "Checkout" button.

---

### User Story 2 - Empty Cart Experience & Wishlist Recovery (Screen 45) (Priority: P2)

As a shopper with an empty cart who has saved products in my wishlist, I want to see a clear empty state message and a list of my wishlist items with a 1-tap "Add to Cart" button, so that I can easily move saved favorites into my cart and proceed with shopping.

**Why this priority**: Prevents user drop-off upon seeing an empty cart. Providing direct access to wishlist items converts passive intent into active shopping.

**Independent Test**: Navigate to `/cart` with an empty cart when the user has wishlist items. Verify the header shows "Cart" with a `0` badge. Verify the center shows a circular icon containing a blue shopping bag with a dollar symbol and the text "Your Cart is Empty". Verify the "From Your Wishlist" section renders below with vertical wishlist item cards (product photo, title, price `$17,00`, `Pink` & `M` pills, trash icon, and blue cart icon button). Tap the blue cart icon button on a wishlist item. Verify the item is immediately added to the cart, the screen transitions to Screen 44 (populated cart), the header badge updates to `1`, the total updates to `$17,00`, and the Checkout button becomes enabled.

**Acceptance Scenarios**:

1. **Given** the cart contains no items and the user has saved wishlist products, **When** `/cart` is opened, **Then** the empty cart illustration appears centered with the bold headline "Your Cart is Empty".
2. **Given** the empty cart state, **When** rendered, **Then** the header badge displays `0`, the bottom bar displays `Total: $0,00` in muted grey, and the "Checkout" button is disabled.
3. **Given** the "From Your Wishlist" section on Screen 45, **When** rendered, **Then** it displays a vertical list of saved items, each containing a product image, title, price (`$17,00`), variant pills (`M`, `Pink`), a trash icon (to remove from wishlist), and a circular blue cart icon button.
4. **Given** a wishlist item card on Screen 45, **When** the user taps the blue cart icon button, **Then** the item is added to the cart, the cart transitions out of empty state to Screen 44, the badge updates to `1`, and the checkout bar becomes active.
5. **Given** a wishlist item card on Screen 45, **When** the user taps the trash icon, **Then** the item is removed from the wishlist list without affecting the cart.

---

### User Story 3 - Empty Cart Experience & Popular Product Discovery (Screen 46) (Priority: P3)

As a shopper with an empty cart and no wishlist items, I want to see an engaging empty state and a carousel of trending "Most Popular" products, so that I can discover popular apparel and add items directly to my basket.

**Why this priority**: Essential product discovery fallback. When the user has no wishlist history, trending popular products encourage catalog exploration and prompt immediate purchases.

**Independent Test**: Navigate to `/cart` when both the cart and wishlist are empty (or in popular fallback mode). Verify the empty cart illustration and "Your Cart is Empty" headline are displayed. Verify the "Most Popular" section appears below with header "Most Popular" and a circular blue arrow "See All →". Verify a horizontal carousel displays popular product cards with promotional badges (`New`, `Sale`, `Hot`) and price `$17,80`. Tap "See All →" and verify navigation to `/catalog`. Tap a product card and verify navigation to `/product/:id`. Tap the cart icon on a popular card and verify the product is added to the cart and transitions to Screen 44.

**Acceptance Scenarios**:

1. **Given** the cart is empty and popular recommendations are active, **When** `/cart` is opened, **Then** the empty cart illustration and "Your Cart is Empty" message are displayed.
2. **Given** the "Most Popular" section on Screen 46, **When** rendered, **Then** it features a header with "Most Popular" and a circular blue arrow button labeled "See All →".
3. **Given** the "See All →" button, **When** tapped, **Then** the application navigates to the shop catalog page (`/catalog`).
4. **Given** the popular products carousel, **When** rendered, **Then** it displays horizontal product cards with status badges (`New`, `Sale`, `Hot`), product image, title, rating, and price `$17,80`.
5. **Given** a product card in the popular carousel, **When** tapped on the card body, **Then** the application navigates to `/product/:id`.
6. **Given** a product card in the popular carousel, **When** the cart icon on the card is tapped, **Then** the item is added to the cart and the view dynamically switches to the populated cart view (Screen 44).

---

### User Story 4 - Cross-Selling Recommendations in Active Cart (Screen 44) (Priority: P4)

As a shopper viewing my populated cart, I want to see horizontal "From Your Wishlist" suggestions below my cart items, so that I can cross-sell and add additional favorite items before finalizing my checkout.

**Why this priority**: Increases basket size and average order value by reminding shoppers of items they previously expressed interest in.

**Independent Test**: On Screen 44 with cart items present, scroll down below the cart items list. Verify the "From Your Wishlist" section is displayed with a bold section header and horizontal wishlist cards. Verify each card shows the product image, title, price, variant pills, and a quick-add cart button. Tap the cart icon on a suggested wishlist item and verify it is immediately added as a new item in the cart list above.

**Acceptance Scenarios**:

1. **Given** Screen 44 with populated cart items, **When** the user scrolls past the cart item cards, **Then** a "From Your Wishlist" section appears with a horizontal list of suggested items.
2. **Given** a suggested item in the horizontal wishlist section, **When** the user taps the quick-add cart icon, **Then** the item is appended to the cart items list, the header badge increments, and the total recalculates.

---

### User Story 5 - Checkout Initiation & Shipping Address Navigation (Priority: P5)

As a shopper ready to purchase, I want to review my shipping address destination and tap "Checkout" to proceed to order configuration, so that I can move smoothly to shipping and payment selection.

**Why this priority**: Connects the cart module with the downstream checkout and payment workflows.

**Independent Test**: On Screen 44 with items in the cart, tap the circular blue arrow (`→`) in the Shipping Address card; verify navigation intent to the shipping address management screen (`/checkout/shipping`). Tap the Primary 400 blue "Checkout" button in the sticky bottom bar; verify navigation to `/checkout`. On Screens 45 and 46 (empty cart), tap the "Checkout" button; verify no navigation occurs and button is visibly disabled.

**Acceptance Scenarios**:

1. **Given** the Shipping Address card on Screen 44, **When** the user taps the circular blue arrow (`→`), **Then** the application triggers navigation to `/checkout/shipping`.
2. **Given** the populated cart on Screen 44, **When** the user taps the active "Checkout" button, **Then** the application navigates to `/checkout`.
3. **Given** an empty cart on Screen 45 or Screen 46, **When** the user taps the "Checkout" button, **Then** no navigation occurs because the button is disabled and greyed out.

---

### Edge Cases

- **Minimum Quantity Boundary**: When an item quantity is `1`, tapping the decrement button (`⊖`) does NOT delete the item or drop quantity to `0`. It remains at `1`. Item deletion requires tapping the trash icon.
- **Removing Last Item in Cart**: When the user deletes the only item in the cart, the screen dynamically transitions from Screen 44 to the empty cart state (Screen 45 if wishlist items are present, or Screen 46 if wishlist is empty) without screen reload or blank flash.
- **Empty Cart State Resolution**: When the cart is empty, the system determines whether to show "From Your Wishlist" (Screen 45) or "Most Popular" (Screen 46) based on whether the shopper has items in their wishlist.
- **Rapid Consecutive Taps**: Rapid taps on `⊕` or `⊖` are debounced or processed sequentially so that quantity and total state remain synchronized.
- **Long Text Overflow**: Extremely long product titles or lengthy address strings wrap to a maximum of 2 lines with ellipsis truncation to avoid layout overflow.
- **Currency & Decimal Formatting**: All prices are consistently formatted as `$XX,XX` using the project's Raleway price styling.
- **Shell Navigation Consistency**: The Cart tab in the persistent bottom navigation shell is highlighted in active blue (`#004BFE`) whenever `/cart` is the active route.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a header with the title "Cart" and a dynamic badge circle showing the current number of unique cart items.
- **FR-002**: System MUST render each cart item with its image, title, variant information (size pill, color text), unit price, quantity controls, and delete icon.
- **FR-003**: System MUST allow users to increment item quantity using `⊕` and decrement using `⊖`, enforcing a minimum quantity of 1.
- **FR-004**: System MUST allow users to remove an item from the cart by tapping its trash icon.
- **FR-005**: System MUST reactively calculate and display the total price in the sticky bottom bar whenever quantities change or items are added/removed.
- **FR-006**: System MUST display a Shipping Address card with title, formatted delivery address, and a navigation trigger to change/select addresses.
- **FR-007**: System MUST render an empty cart state when the cart contains 0 items, featuring the empty shopping bag graphic, "Your Cart is Empty" text, a `0` badge, and disabled checkout controls.
- **FR-008**: System MUST conditionally display either the "From Your Wishlist" section (Screen 45) or the "Most Popular" carousel (Screen 46) when the cart is empty.
- **FR-009**: System MUST provide a quick-add action (cart icon) on wishlist items allowing immediate addition to the cart.
- **FR-010**: System MUST allow removing an item from the wishlist suggestions via the wishlist trash icon without affecting cart state.
- **FR-011**: System MUST display the "Most Popular" carousel with promotional badges (`New`, `Sale`, `Hot`), product ratings, and price tags.
- **FR-012**: System MUST navigate to `/catalog` when the user taps "See All →" in the Most Popular section.
- **FR-013**: System MUST navigate to `/product/:id` when the user taps a product card in the Most Popular carousel.
- **FR-014**: System MUST enable the "Checkout" button when the cart contains 1 or more items and disable it when the cart is empty.
- **FR-015**: System MUST navigate to `/checkout` when the enabled "Checkout" button is tapped.
- **FR-016**: System MUST maintain the persistent bottom navigation shell with the Cart tab highlighted in active blue.

### Key Entities *(include if feature involves data)*

- **CartItemEntity**: Represents an item in the cart. Attributes: `id` (String), `product` (ShopProductEntity / product details), `size` (String), `color` (String), `quantity` (int, min 1), `unitPrice` (double), `totalPrice` (computed: `unitPrice * quantity`).
- **ShippingAddressEntity**: Represents the delivery destination. Attributes: `id` (String), `country` (String), `city` (String), `state` (String), `street` (String), `zipCode` (String), `formattedAddress` (String).
- **CartSummaryEntity**: Aggregate state containing: `items` (List<CartItemEntity>), `wishlistSuggestions` (List<CartItemEntity> or product entities), `popularSuggestions` (List<ShopProductEntity>), `subtotal` (double), `itemCount` (int), `shippingAddress` (ShippingAddressEntity).

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Shoppers can review cart items, adjust quantities, and tap Checkout in under 15 seconds.
- **SC-002**: 100% of quantity changes, additions, and deletions update the header badge and total price reactively with zero lag (< 100ms).
- **SC-003**: 100% of empty cart scenarios display actionable recommendations ("From Your Wishlist" or "Most Popular"), enabling 1-tap cart recovery.
- **SC-004**: Zero layout overflow errors across small, standard, and large device screen widths.
- **SC-005**: 100% pixel-perfect compliance with Figma design references `44 CART.png`, `45 CART SHOWN FROM WISHLIST.png`, and `46 CART SHOWN FROM POPULAR.png`.

---

## Assumptions

- **Mock Data Scope**: In Phase 1, cart data, wishlist suggestions, popular suggestions, and the default shipping address are provided by a structured mock data source with in-memory state management.
- **Empty Cart Strategy**: When the cart is empty, the system checks whether wishlist suggestions exist. If present, it presents Screen 45 ("From Your Wishlist"). If the wishlist is empty, it presents Screen 46 ("Most Popular").
- **Product Variant Defaults**: Items added from recommendations default to size `M` and color `Pink` unless specified otherwise.
- **Downstream Routes**: Tapping "Checkout" will navigate to `/checkout`, and tapping the Shipping Address arrow will navigate to `/checkout/shipping`; these downstream screens are scaffolded or routed to handle navigation gracefully until the subsequent `checkout` feature is implemented.
- **Component Reuse**: Existing widgets such as `ShopProductCard`, `DiscountBadge`, and `PrimaryButton` will be reused directly from core/shared widgets.

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
