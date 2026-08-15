import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool isLocalImage;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.isLocalImage = false,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width?.w,
        height: height?.h,
        fit: fit,
        placeholder: (context, url) =>
            placeholder ??
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: const CircularProgressIndicator(strokeWidth: 2.0),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ?? const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
