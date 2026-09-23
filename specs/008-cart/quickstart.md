# Quickstart Validation Guide: Cart Feature (Screens 44, 45, 46)

**Feature**: `specs/008-cart` | **Date**: 2026-09-23

This guide provides step-by-step verification flows to validate the end-to-end functionality and design fidelity of the **Cart** feature.

---

## Prerequisites
- Application running via `flutter run` or target test runner.
- Active bottom navigation shell displaying the 4th tab ("Cart").

---

## Validation Scenarios

### Scenario 1: Populated Cart & Design Token Fidelity (Screen 44)
1. **Action**: Open the application and tap the "Cart" tab in the bottom navigation bar (`/cart`).
2. **Expected Outcome**:
   - Header renders "Cart" with a light blue badge circle displaying count `2`.
   - The Cart tab in the bottom navigation bar is highlighted in active blue (`#004BFE`).
   - Shipping Address card renders with grey background (`#F5F5F5`), title "Shipping Address", address text, and a circular blue arrow button (`→`).
   - 2 cart item cards render with rounded corners (`16.r`), product images (`12.r`), title, variant pills (`M` size pill, `Pink` color text), price `$17,00`, `⊖ 1 ⊕` quantity controls, and red trash icon (`#FF3B30`).
   - Horizontal "From Your Wishlist" section renders below the cart items.
   - Sticky bottom bar renders with `Total:` and `$34,00` in bold Raleway, plus an enabled Primary 400 blue "Checkout" button.

### Scenario 2: Quantity Controls & Dynamic Totals (Screen 44)
1. **Action**: Tap the increment button (`⊕`) on the first cart item.
2. **Expected Outcome**:
   - Item quantity updates from `1` to `2`.
   - Total in the sticky bottom bar updates reactively to `$51,00`.
3. **Action**: Tap the decrement button (`⊖`) on the same item.
4. **Expected Outcome**:
   - Item quantity returns to `1`.
   - Total updates reactively back to `$34,00`.
5. **Action**: Tap `⊖` once more while quantity is `1`.
6. **Expected Outcome**:
   - Quantity remains strictly at `1` (boundary protection; item is not removed).

### Scenario 3: Item Deletion & Empty State Transition (Screen 44 → Screen 45)
1. **Action**: Tap the red trash icon on the first cart item.
2. **Expected Outcome**:
   - The item is removed from the cart.
   - Header badge decrements to `1`.
   - Total updates to `$17,00`.
3. **Action**: Tap the red trash icon on the remaining cart item.
4. **Expected Outcome**:
   - Cart becomes empty.
   - View seamlessly transitions to Screen 45.
   - Empty state graphic displays with blue shopping bag icon + `$` and text "Your Cart is Empty".
   - Header badge shows `0`.
   - Bottom bar shows `Total: $0,00` in grey and the "Checkout" button is visibly disabled.
   - Vertical "From Your Wishlist" list renders below the empty state.

### Scenario 4: 1-Tap Wishlist Quick-Add (Screen 45 → Screen 44)
1. **Action**: In the vertical "From Your Wishlist" section on Screen 45, tap the circular blue cart icon button on a saved item.
2. **Expected Outcome**:
   - The item is added to the cart.
   - Screen instantly transitions from empty state back to populated cart (Screen 44).
   - Header badge updates to `1`.
   - Total updates to `$17,00`.
   - "Checkout" button becomes enabled and blue.

### Scenario 5: Popular Product Carousel & Catalog Navigation (Screen 46)
1. **Action**: When empty cart is in popular discovery mode, view the "Most Popular" section.
2. **Expected Outcome**:
   - "Most Popular" header renders with a circular blue arrow "See All →".
   - Horizontal carousel renders product cards with promotional badges (`New`, `Sale`, `Hot`) and price `$17,80`.
3. **Action**: Tap "See All →".
4. **Expected Outcome**:
   - Application navigates to `/catalog`.
5. **Action**: Navigate back and tap a product card in the popular carousel.
6. **Expected Outcome**:
   - Application navigates to the corresponding product details screen (`/product/:id`).

### Scenario 6: Checkout & Address Triggers
1. **Action**: On Screen 44 with items in cart, tap "Checkout".
2. **Expected Outcome**:
   - Triggers navigation to `/checkout`.
3. **Action**: Tap the circular blue arrow (`→`) in the Shipping Address card.
4. **Expected Outcome**:
   - Triggers navigation to `/checkout/shipping`.
