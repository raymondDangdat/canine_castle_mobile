import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../resources/constants/font_constants.dart';
import '../resources/constants/image_constant.dart';

void customSnackBar(BuildContext context, String message,
    {bool isError = true}) {
  return showTopSnackBar(
    context,
    Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE6E6E6))),
        child: Row(
          children: [
            SizedBox(
                width: 24.h,
                height: 24.h,
                child: SvgPicture.asset(isError ? errorIcon : successIcon)),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(
                message,
                maxLines: 3,
                style: const TextStyle(
                    fontSize: 12,
                    decorationColor: Colors.white,
                    fontWeight: mediumFont,
                    color: Color(0xFF0C0C0C)),
              ),
            )
          ],
        )),
  );
}
