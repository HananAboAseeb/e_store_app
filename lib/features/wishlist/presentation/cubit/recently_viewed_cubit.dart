import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shop/domain/entities/shop_product_entity.dart';
import '../../domain/entities/date_tab_entity.dart';
import '../../domain/entities/recently_viewed_item_entity.dart';
import '../../domain/usecases/get_recently_viewed_usecase.dart';
import 'recently_viewed_state.dart';

class RecentlyViewedCubit extends Cubit<RecentlyViewedState> {
  final GetRecentlyViewedUseCase getRecentlyViewedUseCase;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  RecentlyViewedCubit({
    required this.getRecentlyViewedUseCase,
  }) : super(const RecentlyViewedInitial());

  Future<void> loadRecentlyViewed() async {
    emit(const RecentlyViewedLoading());
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final yesterdayDate = todayDate.subtract(const Duration(days: 1));

    final initialTabs = [
      DateTabEntity(
        id: 'today',
        label: 'Today',
        date: todayDate,
        isPreset: true,
      ),
      DateTabEntity(
        id: 'yesterday',
        label: 'Yesterday',
        date: yesterdayDate,
        isPreset: true,
      ),
    ];

    final result = await getRecentlyViewedUseCase();
    result.fold(
      (failure) => emit(RecentlyViewedError(failure.message)),
      (items) {
        final filtered = _filterItemsForDate(items, todayDate);
        emit(
          RecentlyViewedLoaded(
            tabs: initialTabs,
            activeTabId: 'today',
            allItems: items,
            filteredProducts: filtered,
            isCalendarExpanded: false,
            selectedCalendarDate: todayDate,
            displayedMonth: DateTime(now.year, 4), // Default April per Figma
          ),
        );
      },
    );
  }

  void selectTab(String tabId) {
    if (state is! RecentlyViewedLoaded) return;
    final currentState = state as RecentlyViewedLoaded;
    final tab = currentState.tabs.firstWhere(
      (t) => t.id == tabId,
      orElse: () => currentState.tabs.first,
    );

    final filtered = _filterItemsForDate(currentState.allItems, tab.date);

    emit(
      currentState.copyWith(
        activeTabId: tabId,
        filteredProducts: filtered,
        isCalendarExpanded: false,
      ),
    );
  }

  void toggleCalendar() {
    if (state is! RecentlyViewedLoaded) return;
    final currentState = state as RecentlyViewedLoaded;
    emit(
      currentState.copyWith(
        isCalendarExpanded: !currentState.isCalendarExpanded,
      ),
    );
  }

  void closeCalendar() {
    if (state is! RecentlyViewedLoaded) return;
    final currentState = state as RecentlyViewedLoaded;
    emit(currentState.copyWith(isCalendarExpanded: false));
  }

  void changeMonth(int offset) {
    if (state is! RecentlyViewedLoaded) return;
    final currentState = state as RecentlyViewedLoaded;
    final newMonth = DateTime(
      currentState.displayedMonth.year,
      currentState.displayedMonth.month + offset,
    );
    emit(currentState.copyWith(displayedMonth: newMonth));
  }

  void selectCalendarDate(DateTime date) {
    if (state is! RecentlyViewedLoaded) return;
    final currentState = state as RecentlyViewedLoaded;

    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final yesterdayDate = todayDate.subtract(const Duration(days: 1));
    final selectedDateOnly = DateTime(date.year, date.month, date.day);

    final todayTab = DateTabEntity(
      id: 'today',
      label: 'Today',
      date: todayDate,
      isPreset: true,
    );
    final yesterdayTab = DateTabEntity(
      id: 'yesterday',
      label: 'Yesterday',
      date: yesterdayDate,
      isPreset: true,
    );

    List<DateTabEntity> updatedTabs;
    String activeId;
    DateTime activeDate;

    if (selectedDateOnly == todayDate) {
      updatedTabs = [todayTab, yesterdayTab];
      activeId = 'today';
      activeDate = todayDate;
    } else if (selectedDateOnly == yesterdayDate) {
      updatedTabs = [todayTab, yesterdayTab];
      activeId = 'yesterday';
      activeDate = yesterdayDate;
    } else {
      final monthName = _monthNames[date.month - 1];
      final customLabel = '$monthName, ${date.day}';
      final customId = 'date_${date.year}_${date.month}_${date.day}';
      final customTab = DateTabEntity(
        id: customId,
        label: customLabel,
        date: selectedDateOnly,
        isPreset: false,
      );

      // Replaces "Yesterday" -> Only TWO tabs: [Today, Custom Date]
      updatedTabs = [todayTab, customTab];
      activeId = customId;
      activeDate = selectedDateOnly;
    }

    final filtered = _filterItemsForDate(
      currentState.allItems,
      activeDate,
    );

    emit(
      currentState.copyWith(
        tabs: updatedTabs,
        activeTabId: activeId,
        filteredProducts: filtered,
        isCalendarExpanded: false,
        selectedCalendarDate: date,
      ),
    );
  }

  List<ShopProductEntity> _filterItemsForDate(
    List<RecentlyViewedItemEntity> items,
    DateTime? date,
  ) {
    if (date == null) {
      return items.map((e) => e.product).toList();
    }
    return items
        .where((item) =>
            item.viewedAt.year == date.year &&
            item.viewedAt.month == date.month &&
            item.viewedAt.day == date.day)
        .map((item) => item.product)
        .toList();
  }
}
