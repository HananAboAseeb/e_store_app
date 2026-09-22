import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSizeSelector extends StatefulWidget {
  final List<String> availableSizes;
  final String selectedSize;
  final ValueChanged<String> onSizeSelected;

  const ProductSizeSelector({
    super.key,
    required this.availableSizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  State<ProductSizeSelector> createState() => _ProductSizeSelectorState();
}

class _ProductSizeSelectorState extends State<ProductSizeSelector> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final sizes = widget.availableSizes.isNotEmpty
        ? widget.availableSizes
        : const ['XS', 'S', 'M', 'L', 'XL', '2XL'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            'Size',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF000000),
            ),
          ),
          SizedBox(width: 16.w),
          if (!_isExpanded)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = true;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFECECEC),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.selectedSize,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: sizes.map((size) {
                    final isSelected = size == widget.selectedSize;
                    return GestureDetector(
                      onTap: () {
                        widget.onSizeSelected(size);
                        setState(() {
                          _isExpanded = false;
                        });
                      },
                      child: Container(
                        height: 32.h,
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF004BFE)
                              : const Color(0xFFECECEC),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
