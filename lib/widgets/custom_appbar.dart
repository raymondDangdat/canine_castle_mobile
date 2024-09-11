import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Widgets/title_widget.dart';
import '../resources/constants/color_constants.dart';
import '../resources/constants/dimension_constants.dart';
import '../resources/constants/font_constants.dart';
import '../resources/constants/image_constant.dart';
import 'long_divider.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Widget? widget;
  const CustomAppbar({Key? key, required this.title, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: widget ??
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(backArrowSvg)),
                  TitleWidget(
                    title: title,
                    fontSize: 16,
                    fontWeight: semiBoldFont,
                    textColor: blackTextColor,
                  ),
                  SvgPicture.asset(
                    backArrowSvg,
                    color: Colors.transparent,
                  ),
                ],
              ),
        ),
        SizedBox(
          height: 20.h,
        ),
        const LongDivider(),
      ],
    );
  }
}
