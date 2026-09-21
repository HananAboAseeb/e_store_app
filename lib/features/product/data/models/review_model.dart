import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.authorName,
    required super.authorAvatar,
    required super.rating,
    required super.text,
    required super.likes,
    required super.dislikes,
    super.userVote,
    required super.timeAgo,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String? ?? '',
      authorName: json['authorName'] as String? ?? '',
      authorAvatar: json['authorAvatar'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      text: json['text'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
      userVote: json['userVote'] as bool?,
      timeAgo: json['timeAgo'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'rating': rating,
      'text': text,
      'likes': likes,
      'dislikes': dislikes,
      'userVote': userVote,
      'timeAgo': timeAgo,
    };
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      id: entity.id,
      authorName: entity.authorName,
      authorAvatar: entity.authorAvatar,
      rating: entity.rating,
      text: entity.text,
      likes: entity.likes,
      dislikes: entity.dislikes,
      userVote: entity.userVote,
      timeAgo: entity.timeAgo,
    );
  }
}
