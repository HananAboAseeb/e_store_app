import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryPill extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const SubCategoryPill({
    super.key,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: const Color(0x1A000000),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF000000),
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
