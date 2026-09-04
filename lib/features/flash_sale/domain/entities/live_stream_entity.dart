import 'package:equatable/equatable.dart';

class LiveStreamEntity extends Equatable {
  final String id;
  final String title;
  final String bannerUrl;
  final bool isLive;
  final int? viewerCount;

  const LiveStreamEntity({
    required this.id,
    required this.title,
    required this.bannerUrl,
    this.isLive = true,
    this.viewerCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        bannerUrl,
        isLive,
        viewerCount,
      ];
}
