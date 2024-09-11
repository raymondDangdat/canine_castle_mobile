import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../Widgets/title_widget.dart';
import '../../models/first_step_account_creation.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../utils/constants.dart';
import '../../widgets/components.dart';
import '../../widgets/custom_snack_back.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';
import '../confirm_email/confirm_email_screen.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  void removeLeadingZero() {
    if (phoneNumberController.text.toString().startsWith("0")) {
      phoneNumberController.text =
          phoneNumberController.text.toString().substring(1);
      setState(() {});
    }
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (authProvider.resMessage != '') {
                customSnackBar(context, authProvider.resMessage);

                ///Clear the response message to avoid duplicate
                authProvider.clear();
              }
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: topPadding.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWidget(
                        title: createAnAccount,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        children: [
                          const CustomTextWithLineHeight(
                            text: "Already have an account? ",
                            textColor: black,
                          ),
                          InkWell(
                            onTap: () {
                              navToWithScreenName(
                                  context: context, screen: const LoginScreen());
                            },
                            child: const CustomTextWithLineHeight(
                              text: "Log in",
                              textColor: mainColor,
                              fontWeight: boldFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelWidget(label: fullName),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter your full name",
                                fullNameController,
                                isCapitalizeSentence: true,
                                type: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(
                          label: phoneNumber,
                          textColor: Color(0xFF333333),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 48.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: borderGrey),
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 24.h,
                                      width: 24.h,
                                      decoration: BoxDecoration(
                                        // color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        image: const DecorationImage(
                                            image: AssetImage(nigerianFlag),
                                            fit: BoxFit.cover),
                                        // borderRadius: BorderRadius.circular(100.r)
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    const BodyTextPrimaryWithLineHeight(
                                      text: "+234",
                                      fontSize: 12,
                                      fontWeight: mediumFont,
                                      textColor: black,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    SvgPicture.asset(dropdownIconSvg),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: CustomField(
                                "Number without the leading zero",
                                phoneNumberController,
                                formatters: numbersOnlyFormat,
                                length: 10,
                                type: TextInputType.phone,
                                onChange: (value) {
                                  removeLeadingZero();
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const LabelWidget(label: email),
                        Row(
                          children: [
                            Expanded(
                              child: CustomField(
                                "Enter your email",
                                emailController,
                                isCapitalizeSentence: false,
                                type: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        const LabelWidget(
                          label: password,
                        ),
                        PwdField(
                          hint: "Enter your password",
                          controller: passwordController,
                          isObscured: obscure,
                          hasBorder: true,
                          onTap: () {
                            setState(() => obscure = !obscure);
                          },
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        authProvider.isLoading
                            ? const Center(child: CupertinoActivityIndicator())
                            : MainButton(
                                signUp,
                                () async {
                                  if (fullNameController.text.trim().length <
                                      5) {
                                    customSnackBar(
                                        context, "Enter a valid full name");
                                  } else if (phoneNumberController.text.length <
                                      10) {
                                    customSnackBar(
                                      context,
                                      "Please enter a valid phone number",
                                    );
                                  } else if (emailController.text.length < 4) {
                                    customSnackBar(
                                      context,
                                      "Please enter a valid email",
                                    );
                                  } else if (passwordController.text
                                          .trim()
                                          .length <
                                      8) {
                                    customSnackBar(context,
                                        "Password must be at least 8 characters");
                                  } else if (!passwordController.text
                                      .isValidPassword()) {
                                    customSnackBar(context,
                                        "Password must contain at least one uppercase letter, one lowercase letter, one numeric digit, and one special character.");
                                  } else {
                                    final firstStepAccountCreation =
                                        FirstStepAccountCreation(
                                            phoneNumber:
                                                "0${phoneNumberController.text}",
                                            email: emailController.text,
                                            password: passwordController.text,
                                            fullName:
                                                fullNameController.text.trim(),
                                            vcn: "");
                                    authProvider.updateFirstStepAccountCreation(
                                        firstStepAccountCreation);

                                    // final isRegistered = await authProvider
                                    //     .registerUser(context: context);
                                    // if (isRegistered && context.mounted) {
                                    navToWithScreenName(
                                        context: context,
                                        screen: const ConfirmEmailScreen());
                                    // }
                                  }
                                },
                              ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: SizedBox(
                            width: 258.w,
                            child: const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By clicking the ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign up ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'button, it means you have read our ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms ',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Conditions ',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}
