import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/title_widget.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/components.dart';
import '../login_screen/login_screen.dart';

class PasswordChangedSuccessfullyScreen extends StatefulWidget {
  const PasswordChangedSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<PasswordChangedSuccessfullyScreen> createState() =>
      _PasswordChangedSuccessfullyScreenState();
}

class _PasswordChangedSuccessfullyScreenState
    extends State<PasswordChangedSuccessfullyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 285.h,
                      ),
                      SizedBox(
                        height: 73.h,
                        width: 74.h,
                        child: Image.asset(passwordChangedImg),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      const TitleWidget(
                        title: passwordChanged,
                        fontSize: 23,
                      ),
                      const BodyTextLightWithLineHeight(
                        text: yourPasswordHasBeenChanged,
                        alignCenter: true,
                        fontWeight: mediumFont,
                        textColor: blackTextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: MainButton(
                  "Back to Log in",
                  () async {
                    navToWithScreenName(
                        context: context,
                        screen: const LoginScreen(),
                        isPushAndRemoveUntil: true);
                  },
                ),
              ),
              SizedBox(
                height: bottomPadding.h,
              )
            ],
          )),
    );
  }
}
