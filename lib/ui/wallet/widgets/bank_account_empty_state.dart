import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/image_constant.dart';

class BankAccountEmptyState extends StatelessWidget {
  const BankAccountEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24.h,
          ),
          SvgPicture.asset(bankAccountIcon),
          SizedBox(
            height: 4.h,
          ),
          const BodyTextPrimaryWithLineHeight(
            text: "You have not connected your bank yet",
            textColor: Color.fromRGBO(10, 10, 11, 1),
          )
        ],
      ),
    );
  }
}
