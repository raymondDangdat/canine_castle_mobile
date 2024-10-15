import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';

class SectionWidget extends StatelessWidget {
  final String sectionName;
  const SectionWidget({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: mainGrey,
      padding: EdgeInsets.only(left: horizontalPadding.w, top: 10, bottom: 10),
      child: BodyTextPrimaryWithLineHeight(
        text: sectionName,
        textColor: foundation,
        fontSize: 13,
        fontWeight: mediumFont,
      ),
    );
  }
}
