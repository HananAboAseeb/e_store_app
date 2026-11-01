import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';

/// Design System typography widget.
///
/// Provides named constructors matching the Figma typography scale:
/// - [AppText.h1]            — Large page headings ("Hello, Romina!", "Wishlist", "Cart")
/// - [AppText.h2]            — Section titles ("My Orders", "Stories", "Recently viewed")
/// - [AppText.h3]            — Sub-headings & card titles ("Items", "Announcement")
/// - [AppText.body]          — Primary body text
/// - [AppText.bodySecondary] — Secondary / muted body text
/// - [AppText.caption]       — Small labels, badges, dates
/// - [AppText.price]         — Bold price displays ("$17,00", "$365,00")
class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;

  const AppText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
  });

  /// Large page headings (28sp bold)
  factory AppText.h1(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.h1;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Section headings (22sp w600)
  factory AppText.h2(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.h2;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Sub-headings & card titles (16sp w600)
  factory AppText.h3(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.h3;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Card Titles (Figma 16px Raleway bold)
  factory AppText.cardTitle(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.cardTitle;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Card Descriptions (Figma 12px Nunito Sans regular)
  factory AppText.cardDescription(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.cardDescription;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Primary body text (16sp normal)
  factory AppText.body(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.body;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Secondary/muted body text (14sp normal)
  factory AppText.bodySecondary(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.bodySecondary;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Small labels, dates, indicators (12sp w500)
  factory AppText.caption(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.caption;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  /// Bold price displays (24sp bold)
  factory AppText.price(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    bool? softWrap,
  }) {
    var effectiveStyle = AppTypography.price;
    if (color != null) effectiveStyle = effectiveStyle.copyWith(color: color);
    if (style != null) effectiveStyle = effectiveStyle.merge(style);

    return AppText(
      text,
      key: key,
      style: effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
