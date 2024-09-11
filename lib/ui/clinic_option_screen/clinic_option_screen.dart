import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/components.dart';
import '../../widgets/constant_widgets.dart';
import '../../widgets/custom_appbar.dart';
import '../signup_screen/sign_up_screen.dart';

class ClinicOptionScreen extends StatefulWidget {
  const ClinicOptionScreen({Key? key}) : super(key: key);

  @override
  State<ClinicOptionScreen> createState() => _ClinicOptionScreenState();
}

class _ClinicOptionScreenState extends State<ClinicOptionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          child: Column(
        children: [
          const TopPadding(),
          const CustomAppbar(title: vetProfessional),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BodyTextLightWithLineHeight(
                  text: "Do you own a vet shop /clinic?",
                  fontSize: 23,
                  textColor: blackTextColor,
                  fontWeight: semiBoldFont,
                ),
                const SizedBox(
                  height: 10,
                ),
                const BodyTextLightWithLineHeight(
                    text:
                        "This information will help us to onboard you properly. "),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 52.h,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: MainButton(
                    "No",
                    () {
                      Navigator.pop(context);
                    },
                    color: secondaryColor,
                    textColor: mainColor,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: MainButton(
                    "Yes",
                    () {
                      navToWithScreenName(
                          context: context, screen: const SignUpScreen());
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
