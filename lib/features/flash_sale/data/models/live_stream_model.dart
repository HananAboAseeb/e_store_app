import '../../domain/entities/live_stream_entity.dart';

class LiveStreamModel extends LiveStreamEntity {
  const LiveStreamModel({
    required super.id,
    required super.title,
    required super.bannerUrl,
    super.isLive = true,
    super.viewerCount,
  });

  factory LiveStreamModel.fromJson(Map<String, dynamic> json) {
    return LiveStreamModel(
      id: json['id'] as String,
      title: json['title'] as String,
      bannerUrl: json['bannerUrl'] as String,
      isLive: json['isLive'] as bool? ?? true,
      viewerCount: json['viewerCount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'bannerUrl': bannerUrl,
      'isLive': isLive,
      'viewerCount': viewerCount,
    };
  }
}
