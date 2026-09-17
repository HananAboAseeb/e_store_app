import 'package:equatable/equatable.dart';

class SearchHistoryEntity extends Equatable {
  final String id;
  final String query;
  final DateTime timestamp;

  const SearchHistoryEntity({
    required this.id,
    required this.query,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, query, timestamp];
}
