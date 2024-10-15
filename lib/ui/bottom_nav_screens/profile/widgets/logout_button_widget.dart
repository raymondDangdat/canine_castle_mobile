import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';

import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          logoutAndClearHive(context: context);
        },
        child: BodyTextPrimaryWithLineHeight(
          text: 'Log out',
          textColor: red,
          fontWeight: semiBoldFont,
        ),
      ),
    );
  }
}
