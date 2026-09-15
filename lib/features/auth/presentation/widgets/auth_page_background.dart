import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class AuthPageBackground extends StatelessWidget {
  final String imagePath;
  final double? height;
  final Alignment alignment;
  final bool enableFade;

  const AuthPageBackground({
    super.key,
    required this.imagePath,
    this.height,
    this.alignment = Alignment.topCenter,
    this.enableFade = true,
  });

  @override
  Widget build(BuildContext context) {
    final double h = height ?? 360.0;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: h.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              alignment: alignment,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
            if (enableFade)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.background.withOpacity(0.0),
                      AppColors.background.withOpacity(0.8),
                      AppColors.background,
                    ],
                    stops: const [0.0, 0.5, 0.82, 1.0],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
