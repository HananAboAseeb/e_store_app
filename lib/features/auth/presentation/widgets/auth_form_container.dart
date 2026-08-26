import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthFormContainer extends StatelessWidget {
  final Widget? header;
  final List<Widget> fields;
  final Widget? extraContent;
  final Widget? actions;
  final GlobalKey<FormState>? formKey;
  final double topSpacing;

  const AuthFormContainer({
    super.key,
    this.header,
    required this.fields,
    this.extraContent,
    this.actions,
    this.formKey,
    this.topSpacing = 160.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: topSpacing.h),
                  if (header != null) ...[
                    header!,
                    SizedBox(height: 32.h),
                  ],
                  ...fields,
                  if (extraContent != null) ...[
                    SizedBox(height: 8.h),
                    extraContent!,
                  ],
                ],
              ),
            ),
          ),
        ),
        if (actions != null) actions!,
      ],
    );
  }
}
