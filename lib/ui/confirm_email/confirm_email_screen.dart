import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../Widgets/title_widget.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/components.dart';
import '../../widgets/constant_widgets.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_snack_back.dart';
import '../../widgets/custom_text.dart';
import '../login_screen/login_screen.dart';
import '../vcn_screen/vcn_screen.dart';

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  Color incompleteContainerColor = const Color(0xFF282828);
  Color completeContainerColor = const Color.fromRGBO(49, 184, 95, 1);
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    customSnackBar(context,
        "6-digit Verification code has been send to your email address.");
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          // top: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopPadding(),
              const CustomAppbar(title: emailVerification),
              SizedBox(
                height: 31.h,
              ),
              Expanded(
                child:
                    Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (authProvider.resMessage != '') {
                      customSnackBar(context, authProvider.resMessage);

                      ///Clear the response message to avoid duplicate
                      authProvider.clear();
                    }
                  });
                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWidget(
                          title: verifyEmail,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        SizedBox(
                          width: 345.w,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text:
                                      'A verification code has been sent to \n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: authProvider
                                          .firstStepAccountCreation?.email ??
                                      authProvider.emailForPasswordReset,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textStyle: const TextStyle(
                              color: Colors.black, fontWeight: mediumFont),
                          length: 6,
                          obscureText: false,
                          autoFocus: true,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(9.r),
                            fieldHeight: 52,
                            fieldWidth: 47,
                            activeBorderWidth: 1,
                            selectedBorderWidth: 1,
                            inactiveBorderWidth: 1,
                            disabledBorderWidth: 1,
                            errorBorderWidth: 1,
                            activeColor: mainColor,
                            inactiveColor: borderGrey,
                            inactiveFillColor: white,
                            selectedColor: mainColor,
                            selectedFillColor: white,
                            activeFillColor: white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                            setState(() {});
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (!authProvider.isVerifyingOTP ||
                                    !authProvider.requestingOTP) {
                                  authProvider.requestOTP(
                                      email: authProvider
                                              .firstStepAccountCreation
                                              ?.email ??
                                          authProvider.emailForPasswordReset,
                                      context: context);
                                }
                              },
                              child: BodyTextLightWithLineHeight(
                                text: authProvider.requestingOTP
                                    ? "Resending..."
                                    : resendCode,
                                textColor: blackTextColor,
                                fontWeight: mediumFont,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        authProvider.isVerifyingOTP
                            ? const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : MainButton(
                                continueTo,
                                () async {
                                  if (otpController.text
                                              .trim()
                                              .toString()
                                              .length ==
                                          6 &&
                                      !authProvider.isVerifyingOTP) {
                                    final emailVerified =
                                        await authProvider.verifyOTP(
                                            otp: otpController.text,
                                            context: context);
                                    // if (mounted && emailVerified) {
                                    if (authProvider.isDogOwner) {
                                      navToWithScreenName(
                                          context: context,
                                          screen: const LoginScreen());
                                    } else {
                                      navToWithScreenName(
                                          context: context,
                                          screen:
                                              const VCNVerificationScreen());
                                    }
                                    // }
                                  }
                                },
                              ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          )),
    );
  }
}
