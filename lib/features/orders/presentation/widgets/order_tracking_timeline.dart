import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/order_entity.dart';
import 'tracking_step_tile.dart';

class OrderTrackingTimeline extends StatelessWidget {
  final List<TrackingStepEntity> steps;
  final VoidCallback? onLearnMoreTap;

  const OrderTrackingTimeline({
    super.key,
    required this.steps,
    this.onLearnMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final isLast = index == steps.length - 1;

          return TrackingStepTile(
            step: step,
            isLast: isLast,
            onLearnMoreTap: onLearnMoreTap,
          );
        }),
      ),
    );
  }
}
