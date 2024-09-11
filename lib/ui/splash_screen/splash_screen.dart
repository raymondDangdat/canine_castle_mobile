import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/connectivity.dart';
import '../../resources/constants/constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/navigation_utils.dart';
import '../get_started_screen/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashBgColor,
      body: SafeArea(
          bottom: false,
          top: false,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: splashBgColor),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 250.w, child: Image.asset(splashScreenLogo)),
                  SizedBox(
                    height: 9.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _goNext() async {
    debugPrint("CONNECTED TO THE INTERNET============= IN INIT STATE");
    final sharedPref = await SharedPreferences.getInstance();

    // Check for Internet Connection
    bool isConnected = await connectionChecker();
    if (isConnected) {
      debugPrint("CONNECTED TO THE INTERNET=============");
      //OPEN ONBOARDING SCREENS
      if (sharedPref.getBool(showOnBoarding) == null ||
          sharedPref.getBool(showOnBoarding) == true) {
        if (mounted) {
          navToWithScreenName(
              context: context, screen: const GetStartedScreen());
        }
      } else {}
    } else {
      // User Not connected to the Internet
      debugPrint("NOT CONNECTED TO THE INTERNET=============");
      if (mounted) {
        navToWithScreenName(context: context, screen: const GetStartedScreen());
      }
    }
  }
}
