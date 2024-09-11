import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../resources/constants/font_constants.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final int maxLines;
  final bool alignCenter;
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.maxLines = 1,
      this.textColor = const Color.fromRGBO(101, 123, 154, 1),
      this.fontWeight = regularFont,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class CustomTextNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  final double lineHeight;
  const CustomTextNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.lineHeight = 1.5,
      this.textColor = const Color.fromRGBO(101, 123, 154, 1),
      this.fontWeight = regularFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
    );
  }
}

class CustomTextWithLineHeight extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  final bool alignCenter;
  const CustomTextWithLineHeight(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.lineHeight = 1.5,
      this.textColor = const Color.fromRGBO(52, 52, 52, 1),
      this.fontWeight = regularFont,
      this.alignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      // overflow: TextOverflow.ellipsis,
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final bool isUpperCase;
  final FontWeight fontWeight;
  const HeaderText({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.isUpperCase = true,
    this.textColor = const Color.fromRGBO(28, 69, 135, 1),
    this.fontWeight = semiBoldFont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpperCase ? text.toUpperCase() : text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BodyTextLightTextColor extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const BodyTextLightTextColor(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(101, 123, 154, 1),
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BodyTextPrimaryTextColor extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const BodyTextPrimaryTextColor(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(28, 69, 135, 1),
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class BodyTextLightWithLineHeight extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  final bool alignCenter;
  final bool underline;
  const BodyTextLightWithLineHeight(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.lineHeight = 1.38,
      this.textColor = const Color.fromRGBO(100, 103, 115, 1),
      this.fontWeight = regularFont,
      this.alignCenter = false,
      this.underline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignCenter ? TextAlign.center : TextAlign.start,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          underLine: underline,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      // overflow: TextOverflow.ellipsis,
    );
  }
}

class GradientTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  final bool alignCenter;
  final List<Color> gradientColors;
  const GradientTextWidget(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.lineHeight = 1.38,
      this.textColor = const Color.fromRGBO(100, 103, 115, 1),
      this.fontWeight = regularFont,
      this.alignCenter = false,
      required this.gradientColors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientText(text,
        style: getCustomTextStyle(
            fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
        colors: gradientColors);

    //   Text(
    //   text,
    //   textAlign: alignCenter ? TextAlign.center : TextAlign.start,
    //   style: getTextStyleWithLineHeight(
    //       fontSize: fontSize,
    //       textColor: textColor,
    //       fontWeight: fontWeight,
    //       lineHeight: lineHeight),
    //   // overflow: TextOverflow.ellipsis,
    // );
  }
}

class BodyTextPrimaryWithLineHeight extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  final bool alignCenter;
  final bool alignEnd;
  final double letterSpacing;
  final bool showLineThrough;
  final bool underLine;
  final int? maxLines;
  final String fontFamily;
  const BodyTextPrimaryWithLineHeight({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.lineHeight = 1.38,
    this.fontFamily = FontConstants.fontFamily,
    this.textColor = const Color.fromRGBO(0, 0, 0, 0.58),
    this.fontWeight = regularFont,
    this.letterSpacing = 0,
    this.alignCenter = false,
    this.alignEnd = false,
    this.maxLines,
    this.showLineThrough = false,
    this.underLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      textAlign: alignCenter
          ? TextAlign.center
          : alignEnd
              ? TextAlign.end
              : TextAlign.start,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          lineHeight: lineHeight,
          fontFamily: fontFamily,
          showLineThrough: showLineThrough,
          underLine: underLine),
      // overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomTextUnderLined extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const CustomTextUnderLined(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getDecoratedTextStyle(fontSize: fontSize, textColor: textColor),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SemiBold12px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  const SemiBold12px(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.textColor = const Color.fromRGBO(0, 0, 0, 1),
      this.lineHeight = 1.3,
      this.fontWeight = semiBoldFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SemiBold14px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final int? maxLines;
  final FontWeight fontWeight;
  const SemiBold14px(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.maxLines,
      this.fontWeight = semiBoldFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
    );
  }
}

class SemiBold16px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const SemiBold16px(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.textColor = const Color.fromRGBO(44, 44, 58, 1),
      this.fontWeight = semiBoldFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SemiBold18px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const SemiBold18px(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = semiBoldFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SemiBold20px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  const SemiBold20px(
      {Key? key,
      required this.text,
      this.fontSize = 20,
      this.textColor = const Color.fromRGBO(48, 80, 130, 1),
      this.lineHeight = 1.32,
      this.fontWeight = semiBoldFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Medium12px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  const Medium12px(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.lineHeight = 1.3,
      this.fontWeight = mediumFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Regular12px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double lineHeight;
  const Regular12px(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.textColor = const Color.fromRGBO(14, 14, 14, 1),
      this.lineHeight = 1.3,
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyleWithLineHeight(
          fontSize: fontSize,
          textColor: textColor,
          fontWeight: fontWeight,
          lineHeight: lineHeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Medium14px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const Medium14px(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(44, 44, 58, 1),
      this.fontWeight = mediumFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class RegularBold16px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const RegularBold16px(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class RegularBold14px extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  const RegularBold14px(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = regularFont})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Medium12pxNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const Medium12pxNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = mediumFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}

class Medium14pxNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const Medium14pxNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = mediumFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}

class Medium16pxNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const Medium16pxNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = mediumFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}

class SemiBold12pxNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const SemiBold12pxNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 12,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = semiBoldFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}

class SemiBold14pxNoOverFlow extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final String alignment;
  const SemiBold14pxNoOverFlow(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.textColor = const Color.fromRGBO(133, 133, 133, 1),
      this.fontWeight = semiBoldFont,
      this.alignment = "start"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment == "end"
          ? TextAlign.end
          : alignment == "center"
              ? TextAlign.center
              : TextAlign.start,
      style: getCustomTextStyle(
          fontSize: fontSize, textColor: textColor, fontWeight: fontWeight),
    );
  }
}
