import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackPocketLogoWidget extends StatelessWidget {
  const BackPocketLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 100.w,
      decoration:
          const BoxDecoration(image: DecorationImage(image: AssetImage(""))),
    );
  }
}
