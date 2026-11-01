import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_activity_summary_usecase.dart';
import 'my_activity_state.dart';

class MyActivityCubit extends Cubit<MyActivityState> {
  final GetActivitySummaryUseCase getActivitySummaryUseCase;

  static const List<String> _months = [
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

  int _currentMonthIndex = 3; // April

  MyActivityCubit({
    required this.getActivitySummaryUseCase,
  }) : super(MyActivityInitial());

  Future<void> loadActivity({String? month}) async {
    emit(MyActivityLoading());
    final targetMonth = month ?? _months[_currentMonthIndex];
    final result = await getActivitySummaryUseCase(targetMonth);
    result.fold(
      (failure) => emit(MyActivityError(failure)),
      (summary) => emit(MyActivityLoaded(summary: summary)),
    );
  }

  void changeMonth(int offset) {
    _currentMonthIndex = (_currentMonthIndex + offset) % _months.length;
    if (_currentMonthIndex < 0) {
      _currentMonthIndex += _months.length;
    }
    loadActivity(month: _months[_currentMonthIndex]);
  }
}
