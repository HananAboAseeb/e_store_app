# Feature Specification: Home (Shop Screen)

**Feature Branch**: `002-home-shop-screen`

**Created**: 2026-08-28

**Status**: Draft

**Input**: User description: "Feature: Home (Shop Screen) — Main landing screen of the e-commerce app. Single scrollable page with multiple sections. Phase 1 — UI Only with Mock Data."

---

## 1. Executive Summary & Design Blueprint

The Home (Shop Screen) serves as the primary storefront and landing experience of the ShopX e-commerce mobile application. It presents a rich, multi-section scrollable catalog featuring promotional campaigns, category navigation, flash sales with live timers, curated recommendations, and top-trending products.

All visual parameters, component dimensions, typography tokens, and color values have been extracted pixel-by-pixel from the official Figma design references (`assets/design_references/home_screen.png` and `assets/design_references/home_screen13.png`).

---

## 2. Design Tokens & Visual Specifications (Pixel-Perfect Analysis)

### 2.1 Design Grid & Layout Tokens
- **Design Resolution Base**: `375 × 812` (iPhone Standard via `flutter_screenutil`)
- **Screen Background**: `#FFFFFF` (`AppColors.background`)
- **Horizontal Screen Padding**: `16.w`
- **Section Vertical Gap**: `24.h`
- **Section Header Bottom Gap**: `12.h`

### 2.2 Section-by-Section Design Parameter Breakdown

#### Section 1: Top AppBar / Search Header
- **Layout**: Row with Title on the left and Search Bar on the right
- **Title ("Shop")**:
  - Font: `AppTypography.h1`, `fontSize: 28.sp`, `fontWeight: FontWeight.bold`, color: `AppColors.textPrimary` (`#1A1A1A`)
- **Search Field**:
  - Container: Height `42.h`, Width `215.w`, `borderRadius: 20.r`, background: `AppColors.surface` (`#F4F4F4`)
  - Leading Icon: `Icons.search_rounded`, `size: 20.sp`, color: `AppColors.textSecondary` (`#8E8E93`)
  - Placeholder Text: `"Search"`, `fontSize: 14.sp`, color: `AppColors.textSecondary`
  - Trailing Action: Camera icon (`Icons.camera_alt_outlined` / SVG), `size: 20.sp`, color: `AppColors.primary400` (`#004BFE`)
  - Padding: `EdgeInsets.symmetric(horizontal: 14.w)`

#### Section 2: Big Sale Hero Banner & Carousel
- **Banner Container**:
  - Dimensions: Width `double.infinity`, Height `180.h`
  - Shape: `borderRadius: 24.r`
  - Background: LinearGradient from vibrant royal blue `#004BFE` (left) to deep navy `#001850` (right) with geometric accent angles
- **Banner Content**:
  - Left Text Block:
    - Headline: `"Big Sale"`, `fontSize: 26.sp`, `fontWeight: FontWeight.bold`, color: `#FFFFFF`
    - Subtitle: `"Up to 50%"`, `fontSize: 14.sp`, `fontWeight: FontWeight.w500`, color: `rgba(255, 255, 255, 0.85)`
    - Spacing: `top: 36.h`, `left: 20.w`
  - Right Image:
    - Visual: Full-height smiling woman holding vibrant shopping bags (`BoxFit.contain`, aligned bottom right)
- **Carousel Dot Indicators (Below Banner)**:
  - Distance below banner: `12.h`
  - Dot Count: 6 indicators
  - Active Dot (Index 0): Pill shape `width: 24.w, height: 6.h`, `borderRadius: 3.r`, color: `AppColors.primary400` (`#004BFE`)
  - Inactive Dots: Circular `width: 6.w, height: 6.w`, shape: `BoxShape.circle`, color: `AppColors.primary50` (`#BFD2FF`)
  - Spacing between dots: `5.w`

#### Section 3: Categories Section
- **Section Header**:
  - Title: `"Categories"`, `fontSize: 20.sp`, `fontWeight: FontWeight.bold`, color: `AppColors.textPrimary`
  - Action: `"See All"` text (`fontSize: 14.sp`, `fontWeight: FontWeight.w600`) + Circular Blue Arrow button (`size: 28.w`, circle, color `#004BFE`, white arrow `16.sp`)
- **Category Card Layout (2-Column Grid)**:
  - Card Container: Width `166.w`, padding `8.w`, background `#FFFFFF`, `borderRadius: 16.r`, border: `Border.all(color: Color(0xFFF0F0F0), width: 1)`
  - Dual Preview Boxes:
    - 2 rounded boxes side-by-side inside card
    - Dimensions: Width `71.w`, Height `72.h`, `borderRadius: 12.r`, background: `Color(0xFFF4F5F7)`
    - Image fit: `BoxFit.contain`, centered
  - Bottom Label & Count:
    - Left Title: Category name (e.g., `"Clothings"`, `"Shoes"`, `"Bags"`, `"Hoodies"`, `"Watch"`), `fontSize: 13.sp`, `fontWeight: FontWeight.bold`, color `#1A1A1A`
    - Right Badge: Item count (e.g., `"109"`, `"530"`, `"87"`), pill background `Color(0xFFEBF1FF)`, text color `AppColors.primary300` (`#2968FF`), `fontSize: 11.sp`, `fontWeight: FontWeight.bold`, padding `horizontal: 6.w, vertical: 2.h`, `borderRadius: 6.r`

#### Section 4: Top Products Section
- **Section Header**: Title `"Top Products"`, `fontSize: 20.sp`, `fontWeight: FontWeight.bold`
- **Layout**: Horizontal Scroll List (`ListView.separated`, horizontal, height `72.h`)
- **Card**:
  - Size: `68.w × 68.h`, `borderRadius: 16.r`
  - Background: `Color(0xFFF4F5F7)`
  - Content: Centered product clothing outfit image (`BoxFit.contain`)
  - Item spacing: `10.w`

#### Section 5: New Items Section
- **Section Header**: Title `"New Items"`, `"See All"` + Blue Circle Arrow
- **Layout**: Horizontal Scroll List (`height: 228.h`)
- **Product Card**:
  - Dimensions: Width `140.w`, margin right `12.w`
  - Image Box: Width `140.w`, Height `140.h`, `borderRadius: 16.r`, background `Color(0xFFF4F5F7)`, `BoxFit.cover`
  - Title: 2 lines max, `"Lorem ipsum dolor sit amet consectetur."`, `fontSize: 12.sp`, `color: AppColors.textPrimary`, `height: 1.3`
  - Price: `"$17,00"`, `fontSize: 14.sp`, `fontWeight: FontWeight.bold`, color `AppColors.textPrimary`
  - Spacing: `image to title: 8.h`, `title to price: 4.h`

#### Section 6: Flash Sale Section
- **Section Header**:
  - Title: `"Flash Sale"`, `fontSize: 20.sp`, `fontWeight: FontWeight.bold`
  - Countdown Timer (Right side):
    - Stopwatch Icon: `Icons.timer_outlined`, color `AppColors.primary400`, `size: 18.sp`
    - 3 Numeric Boxes: `[00]  [36]  [58]` (Hours, Minutes, Seconds)
    - Box Style: Background `Color(0xFFEAEAEA)`, `borderRadius: 6.r`, padding `horizontal: 6.w, vertical: 2.h`, text `fontSize: 12.sp`, `fontWeight: FontWeight.bold`, color `#1A1A1A`
    - Box gap: `4.w`
- **Grid Layout (3 Columns × 2 Rows = 6 Items)**:
  - Card Size: Width `106.w`, Height `106.h`
  - Image: `borderRadius: 16.r`, background `Color(0xFFF4F5F7)`, `BoxFit.cover`
  - Discount Badge (Top-Right Overlay):
    - Background: Vibrant Coral Red `#FF334B` (or `#FF2D55`)
    - Text: `"-20 %"`, color `#FFFFFF`, `fontSize: 10.sp`, `fontWeight: FontWeight.bold`
    - Shape: Pill `borderRadius: 6.r`, padding `horizontal: 5.w, vertical: 2.h`
    - Position: `top: 6.h, right: 6.w`

#### Section 7: Most Popular Section
- **Section Header**: Title `"Most Popular"`, `"See All"` + Blue Circle Arrow
- **Layout**: Horizontal Scroll List (`height: 170.h`)
- **Product Card**:
  - Dimensions: Width `120.w`, margin right `12.w`
  - Image Box: Width `120.w`, Height `120.h`, `borderRadius: 16.r`, background `Color(0xFFF4F5F7)`
  - Bottom Meta Row:
    - Left: Like count with Blue Heart icon e.g. `"1780 💙"`, `fontSize: 12.sp`, `fontWeight: FontWeight.bold`, blue heart color `#004BFE`
    - Right: Category tag e.g. `"New"`, `"Sale"`, `"Hot"`, `fontSize: 11.sp`, color `AppColors.textSecondary` (`#8E8E93`)

#### Section 8: Stuff For You Section
- **Section Header**:
  - Leading Icon: Blue Star icon (`Icons.star_rounded`), color `AppColors.primary400`, `size: 22.sp`
  - Title: `"Stuff for you"`, `fontSize: 20.sp`, `fontWeight: FontWeight.bold`, color `AppColors.textPrimary`
- **Layout**: 2-Column Vertical Grid (`GridView.builder` with `physics: NeverScrollableScrollPhysics()`)
- **Product Card**:
  - Image Box: Width `164.w`, Height `164.h`, `borderRadius: 16.r`, background `Color(0xFFF4F5F7)`, `BoxFit.cover`
  - Title: 2 lines max, `"Lorem ipsum dolor sit amet consectetur"`, `fontSize: 12.sp`, color `AppColors.textPrimary`
  - Price: `"$17,00"`, `fontSize: 14.sp`, `fontWeight: FontWeight.bold`, color `AppColors.textPrimary`
  - Spacing: `image to title: 8.h`, `title to price: 4.h`

#### Section 9: Persistent Bottom Navigation Shell
- **Container**: Height `60.h` (plus system bottom padding), background `#FFFFFF`, subtle top shadow (`blurRadius: 10, color: Colors.black.withOpacity(0.04)`)
- **5 Navigation Tab Items (Icons Only)**:
  1. **Home Tab** (Index 0, Active): Solid filled home icon, color `AppColors.primary400` (`#004BFE`), `size: 24.sp`
  2. **Wishlist Tab** (Index 1): Outline heart icon, color `#8E8E93`, `size: 24.sp`
  3. **Catalog Tab** (Index 2): Outline list/grid icon, color `#8E8E93`, `size: 24.sp`
  4. **Cart Tab** (Index 3): Outline shopping bag icon, color `#8E8E93`, `size: 24.sp`
  5. **Profile Tab** (Index 4): Outline person/user icon, color `#8E8E93`, `size: 24.sp`

---

## 3. User Scenarios & Testing

### User Story 1 — Browsing Store Landing & Featured Promotions (Priority: P1)
As a shopper, I want to open the app and instantly view active sales banners, top categories, and trending products so that I can explore deals and catalog items easily.

**Why this priority**: Core value of the application; initial viewport that drives engagement.

**Independent Test**: Can be validated by opening the app at `/home` and inspecting all 8 catalog sections with mock data loaded and shimmer animation during loading.

**Acceptance Scenarios**:
1. **Given** the app is launched and user reaches the Home screen, **When** data is loading, **Then** elegant shimmer placeholders are displayed matching the card dimensions.
2. **Given** mock data is resolved (1-2s delay), **When** the page renders, **Then** all 8 sections are populated with images, badges, prices, and countdown timer.
3. **Given** the hero banner is displayed, **When** user scrolls/swipes banners, **Then** the active pill dot indicator updates its index.

---

### User Story 2 — Category & Product Discovery Navigation (Priority: P2)
As a shopper, I want to tap on category cards, "See All" buttons, and product cards so that I can drill down into specific collections or product details in future phases.

**Why this priority**: Connects landing experience to product catalogs.

**Independent Test**: Can be tested by tapping category cards and product items to verify touch feedback and navigation callbacks.

**Acceptance Scenarios**:
1. **Given** the Categories section, **When** user taps a category card or "See All", **Then** appropriate navigation callback or stub route is triggered.
2. **Given** any product card in "New Items", "Flash Sale", "Most Popular", or "Stuff for you", **When** user taps a card, **Then** product detail intent is captured.

---

### User Story 3 — Flash Sale Live Countdown Feedback (Priority: P3)
As a shopper, I want to see a live countdown timer on flash sales so that I know how much time is remaining for limited-time offers.

**Why this priority**: Enhances urgency and visual polish matching Figma.

**Independent Test**: Timer ticks down seconds reliably while widget is mounted.

**Acceptance Scenarios**:
1. **Given** Flash Sale section is visible, **When** time elapses, **Then** seconds and minutes decrement smoothly in `[HH] [MM] [SS]` format.

---

## 4. Requirements & Architecture Checklist

### 4.1 Functional Requirements
- **FR-001**: System MUST display a scrollable Home page consisting of: Top Header/Search, Big Sale Carousel, Categories Grid, Top Products row, New Items row, Flash Sale grid with timer, Most Popular row, and Stuff for you grid.
- **FR-002**: System MUST use Clean Architecture layers:
  - `features/home/presentation/` (Pages, Cubit, State, Widgets)
  - `features/home/domain/` (Entities, Repositories, UseCases)
  - `features/home/data/` (Models, DataSources, RepositoryImpl)
- **FR-003**: System MUST provide comprehensive mock data with 1.2s simulated latency returning realistic e-commerce products, categories, and banners.
- **FR-004**: System MUST maintain state immutability via `Equatable` on all entities and states.
- **FR-005**: System MUST use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`) for all UI sizing.
- **FR-006**: System MUST isolate each section into an independent reusable widget inside `lib/features/home/presentation/widgets/`.

### 4.2 Key Domain Entities
- **BannerItem**: `id`, `title`, `subtitle`, `imageUrl`, `discountPercentage`, `backgroundColor`
- **CategoryEntity**: `id`, `name`, `itemCount`, `previewImageUrls` (list of 2 images)
- **ProductEntity**: `id`, `title`, `price`, `imageUrl`, `discountPercentage`, `likeCount`, `tag` (`new`, `sale`, `hot`), `isFavorite`

---

## 5. Reusable Component Matrix (Presentation Widgets)

| Widget File | Purpose & Responsibilities |
|---|---|
| [`home_app_bar.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/home_app_bar.dart) | "Shop" title and pill search bar with camera trigger |
| [`home_hero_banner.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/home_hero_banner.dart) | Big Sale banner card with text, image, and 6-dot carousel indicator |
| [`home_section_header.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/home_section_header.dart) | Reusable header with title, optional leading star icon, and "See All" blue circular arrow |
| [`category_card.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/category_card.dart) | 2-image preview card with category title and item count pill badge |
| [`top_products_bar.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/top_products_bar.dart) | Horizontal list of rounded outfit product thumbnails |
| [`product_card_standard.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/product_card_standard.dart) | Standard product card with image, 2-line title, and price (used in New Items & Stuff for you) |
| [`flash_sale_card.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/flash_sale_card.dart) | Compact product card with coral discount percentage badge overlay |
| [`popular_product_card.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/popular_product_card.dart) | Product card with like count, blue heart, and status tag (New/Sale/Hot) |
| [`flash_sale_timer.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/flash_sale_timer.dart) | Stopwatch icon + 3-box countdown timer widget |
| [`home_shimmer_loading.dart`](file:///e:/e_store/e_store/lib/features/home/presentation/widgets/home_shimmer_loading.dart) | Shimmer placeholder matching exact layout during loading state |

---

## 6. Success Criteria & Quality Verification

- **SC-001**: 100% visual alignment with Figma reference images (`home_screen.png` and `home_screen13.png`).
- **SC-002**: Zero lint errors or warnings reported by `flutter analyze`.
- **SC-003**: Clean layer separation: presentation contains no business logic, domain contains no UI/data dependencies.
- **SC-004**: Smooth 60fps scrolling performance with zero layout overflow exceptions across all device sizes.
