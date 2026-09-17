import '../../domain/entities/search_history_entity.dart';

class SearchHistoryModel extends SearchHistoryEntity {
  const SearchHistoryModel({
    required super.id,
    required super.query,
    required super.timestamp,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'] as String,
      query: json['query'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'query': query,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory SearchHistoryModel.fromEntity(SearchHistoryEntity entity) {
    return SearchHistoryModel(
      id: entity.id,
      query: entity.query,
      timestamp: entity.timestamp,
    );
  }
}
