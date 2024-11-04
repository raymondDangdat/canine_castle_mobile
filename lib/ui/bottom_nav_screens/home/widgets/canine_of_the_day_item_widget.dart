import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Widgets/custom_text.dart';

class CanineOfTheDayItemWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final Color bgColor;
  final Color textColor;
  const CanineOfTheDayItemWidget(
      {super.key,
      required this.title,
      required this.iconName,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconName),
          const SizedBox(
            width: 2,
          ),
          BodyTextPrimaryWithLineHeight(
            text: title,
            textColor: textColor,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
