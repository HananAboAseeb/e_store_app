import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String authorName;
  final String authorAvatar;
  final double rating;
  final String text;
  final int likes;
  final int dislikes;
  final bool? userVote; // true = liked, false = disliked, null = none
  final String timeAgo;

  const ReviewEntity({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.rating,
    required this.text,
    required this.likes,
    required this.dislikes,
    this.userVote,
    required this.timeAgo,
  });

  ReviewEntity copyWith({
    String? id,
    String? authorName,
    String? authorAvatar,
    double? rating,
    String? text,
    int? likes,
    int? dislikes,
    bool? Function()? userVote,
    String? timeAgo,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      rating: rating ?? this.rating,
      text: text ?? this.text,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      userVote: userVote != null ? userVote() : this.userVote,
      timeAgo: timeAgo ?? this.timeAgo,
    );
  }

  @override
  List<Object?> get props => [
        id,
        authorName,
        authorAvatar,
        rating,
        text,
        likes,
        dislikes,
        userVote,
        timeAgo,
      ];
}
