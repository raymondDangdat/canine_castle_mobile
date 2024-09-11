import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/components.dart';
import '../../widgets/modals/registration_option_modal.dart';
import '../login_screen/login_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  List<String> onBoardingImages = [
    onBoarding1,
    onBoarding2,
    onBoarding3,
    onBoarding4
  ];

  late Timer _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Run the _updateCounter function every 2 second
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (currentIndex < onBoardingImages.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        //  Reset current Index
        setState(() {
          currentIndex = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    // Dispose the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 63.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: Container(
                  height: 346.h,
                  width: 315.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(onBoardingImages[currentIndex]),
                          fit: BoxFit.cover)),
                )),
            SizedBox(
              height: 52.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                children: [
                  const Row(
                    children: [
                      BodyTextLightWithLineHeight(
                        text: canineCastleHomeForDong,
                        fontWeight: semiBoldFont,
                        textColor: blackTextColor,
                        fontSize: 32,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 52.h,
                  ),
                  MainButton(
                    getStarted,
                    () {
                      showRegistrationOptionModal(context);
                    },
                  ),
                  SizedBox(
                    height: 52.h,
                  ),
                  InkWell(
                    onTap: () {
                      navToWithScreenName(
                          context: context, screen: const LoginScreen());
                    },
                    child: const Row(
                      children: [
                        BodyTextLightWithLineHeight(
                          text: "Already have an account? ",
                          textColor: blackTextColor,
                          fontSize: 14,
                        ),
                        BodyTextLightWithLineHeight(
                          text: "Log in",
                          textColor: mainColor,
                          fontSize: 14,
                          fontWeight: boldFont,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
