import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/activity_summary_entity.dart';

abstract class MyActivityState extends Equatable {
  const MyActivityState();

  @override
  List<Object?> get props => [];
}

class MyActivityInitial extends MyActivityState {}

class MyActivityLoading extends MyActivityState {}

class MyActivityLoaded extends MyActivityState {
  final ActivitySummaryEntity summary;

  const MyActivityLoaded({required this.summary});

  @override
  List<Object?> get props => [summary];
}

class MyActivityError extends MyActivityState {
  final Failure failure;

  const MyActivityError(this.failure);

  @override
  List<Object?> get props => [failure];
}
