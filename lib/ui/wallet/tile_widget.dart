import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';

class TileWidget extends StatelessWidget {
  const TileWidget(
      {super.key,
      required this.leading,
      required this.trailing,
      this.textColor = ashShade});

  final String leading;
  final String trailing;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: leading,
                textColor: ashShade,
                fontSize: 13,
              ),
              CustomText(
                text: trailing,
                textColor: textColor,
                fontSize: 13,
                fontWeight: mediumFont,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SvgPicture.asset(line),
        ),
      ],
    );
  }
}
