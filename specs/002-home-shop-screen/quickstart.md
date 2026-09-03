# Quickstart & Runnable Validation Guide: Home (Shop Screen)

**Feature**: `002-home-shop-screen`  
**Date**: 2026-08-29  

---

## 1. Environment & Setup Checklist

Before running verification for the Home feature:
- Ensure Flutter SDK version matches `.fvmrc` (Flutter 3.x).
- Dependencies configured in `pubspec.yaml`: `flutter_bloc`, `get_it`, `go_router`, `flutter_screenutil`, `shimmer`, `equatable`, `dartz`.
- Run static analysis:
  ```powershell
  fvm flutter analyze
  ```

---

## 2. Launching Home Screen

Run the app targeting `lib/main_dev.dart` with flavor `dev`:
```powershell
fvm flutter run --flavor dev -t lib/main_dev.dart
```

---

## 3. Manual Verification Checklist (Figma Pixel-Perfect Audit)

| # | Inspection Point | Expected Visual Behavior | Status |
|---|---|---|---|
| 1 | **Loading State** | Displays `HomeShimmerLoading` with animated shimmer cards for 1.2s | ⏳ Pending |
| 2 | **Top AppBar** | "Shop" title (`28.sp` bold) + Pill search bar (`width: 215.w`, height `42.h`, blue camera icon) | ⏳ Pending |
| 3 | **Hero Banner** | Vibrant blue gradient card (`180.h`, `24.r` radius) with 6 carousel dots (`width: 24.w` active pill) | ⏳ Pending |
| 4 | **Categories Grid** | 2-column grid cards (`166.w`) with dual preview boxes (`71.w × 72.h`) and count badges e.g. `"109"` | ⏳ Pending |
| 5 | **Top Products** | Horizontal scroll of square outfit thumbnails (`68.w × 68.h`, `borderRadius: 16.r`) | ⏳ Pending |
| 6 | **New Items** | Horizontal scroll of product cards (`140.w`), 2-line title, bold price `"$17,00"` | ⏳ Pending |
| 7 | **Flash Sale** | 3-column grid (`106.w × 106.h` cards) + Coral Red discount badge `"-20 %"` + Live Timer `[00] [36] [58]` | ⏳ Pending |
| 8 | **Most Popular** | Horizontal cards (`120.w`) + Blue heart like count (`"1780 💙"`) + status tag (`"New"`, `"Sale"`, `"Hot"`) | ⏳ Pending |
| 9 | **Stuff For You** | 2-column vertical grid (`164.w × 164.h` image) with Blue Star header icon | ⏳ Pending |
| 10 | **Bottom Nav** | Persistent 5-tab shell (`60.h`), Home active icon (`#004BFE`), outline icons for others | ⏳ Pending |
