import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CategoriesAppBar extends StatelessWidget {
  final VoidCallback onClose;

  const CategoriesAppBar({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.5.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'All Categories',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF000000),
                letterSpacing: -0.5,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 36.r,
              height: 36.r,
              decoration: const BoxDecoration(
                color: Color(0x1A000000),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 18,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
