import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final VoidCallback onTap;
  const ProfileItemWidget(
      {super.key,
      required this.onTap,
      required this.title,
      required this.iconName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset(iconName),
            title: BodyTextPrimaryWithLineHeight(
              text: title,
              textColor: blackTextColor,
              fontSize: 16,
              fontWeight: mediumFont,
            ),
            trailing: SvgPicture.asset(arrowIcon),
          ),
          SvgPicture.asset(line),
        ],
      ),
    );
  }
}
