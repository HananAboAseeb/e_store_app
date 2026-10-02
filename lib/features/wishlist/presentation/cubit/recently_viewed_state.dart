import 'package:equatable/equatable.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/date_tab_entity.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';

abstract class RecentlyViewedState extends Equatable {
  const RecentlyViewedState();

  @override
  List<Object?> get props => [];
}

class RecentlyViewedInitial extends RecentlyViewedState {
  const RecentlyViewedInitial();
}

class RecentlyViewedLoading extends RecentlyViewedState {
  const RecentlyViewedLoading();
}

class RecentlyViewedLoaded extends RecentlyViewedState {
  final List<DateTabEntity> tabs;
  final String activeTabId;
  final List<RecentlyViewedItemEntity> allItems;
  final List<ShopProductEntity> filteredProducts;
  final bool isCalendarExpanded;
  final DateTime selectedCalendarDate;
  final DateTime displayedMonth;

  const RecentlyViewedLoaded({
    required this.tabs,
    required this.activeTabId,
    required this.allItems,
    required this.filteredProducts,
    this.isCalendarExpanded = false,
    required this.selectedCalendarDate,
    required this.displayedMonth,
  });

  RecentlyViewedLoaded copyWith({
    List<DateTabEntity>? tabs,
    String? activeTabId,
    List<RecentlyViewedItemEntity>? allItems,
    List<ShopProductEntity>? filteredProducts,
    bool? isCalendarExpanded,
    DateTime? selectedCalendarDate,
    DateTime? displayedMonth,
  }) {
    return RecentlyViewedLoaded(
      tabs: tabs ?? this.tabs,
      activeTabId: activeTabId ?? this.activeTabId,
      allItems: allItems ?? this.allItems,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isCalendarExpanded: isCalendarExpanded ?? this.isCalendarExpanded,
      selectedCalendarDate: selectedCalendarDate ?? this.selectedCalendarDate,
      displayedMonth: displayedMonth ?? this.displayedMonth,
    );
  }

  @override
  List<Object?> get props => [
        tabs,
        activeTabId,
        allItems,
        filteredProducts,
        isCalendarExpanded,
        selectedCalendarDate,
        displayedMonth,
      ];
}

class RecentlyViewedError extends RecentlyViewedState {
  final String message;

  const RecentlyViewedError(this.message);

  @override
  List<Object?> get props => [message];
}
