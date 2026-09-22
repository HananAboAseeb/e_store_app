import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/specification_entity.dart';

class ProductSpecificationsSection extends StatelessWidget {
  final List<SpecificationEntity> specifications;
  final VoidCallback? onSizeGuideTap;

  const ProductSpecificationsSection({
    super.key,
    required this.specifications,
    this.onSizeGuideTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specifications',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(height: 14.h),

          // Material Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 72.w,
                child: Text(
                  'Material',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              Expanded(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDEEEC),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Cotton: 95%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDEEEC),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Nylon: 5%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF222222),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Origin Row
          Row(
            children: [
              SizedBox(
                width: 75.w,
                child: Text(
                  'Origin',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EEFA),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'EUROPE',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Size Guide Row
          Row(
            children: [
              Text(
                'Size Guide',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: onSizeGuideTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 34.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF004BFE),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
