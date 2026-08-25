import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;

  const WelcomeBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Background Image (bubble5)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 380.h,
            child: Image.asset(
              'assets/images/bubble5.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/bubbles5.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ),
        ),

        // Bottom Background Image (bubble6)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 320.h,
            child: Image.asset(
              'assets/images/bubble6.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/bubbles6.png',
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ),
        ),

        // Foreground content
        SafeArea(child: child),
      ],
    );
  }
}
