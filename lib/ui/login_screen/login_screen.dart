import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../widgets/components.dart';
import '../../widgets/custom_snack_back.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/modals/registration_option_modal.dart';
import '../../widgets/textfields.dart';
import '../bottom_nav_screens/bottom_nav_screen.dart';
import '../forgot_password_flow/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void initState() {
    emailController.text = kDebugMode ? "realdangdat@gmail.com" : '';
    passwordController.text = kDebugMode ? "Smart001!" : '';
    super.initState();
  }

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
              SizedBox(
                height: topPadding.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 28.h,
                      ),
                      const Row(
                        children: [
                          CustomTextWithLineHeight(
                            text: welcomeBack,
                            textColor: blackTextColor,
                            fontWeight: boldFont,
                            fontSize: 23,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        children: [
                          const CustomTextWithLineHeight(
                            text: "New user? ",
                            textColor: blackTextColor,
                            fontWeight: mediumFont,
                            fontSize: 14,
                          ),
                          InkWell(
                            onTap: () {
                              showRegistrationOptionModal(context);
                            },
                            child: const CustomTextWithLineHeight(
                              text: signUp,
                              textColor: mainColor,
                              fontWeight: boldFont,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
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
                      const LabelWidget(label: password),
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
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          navToWithScreenName(
                              context: context,
                              screen: const ForgotPasswordScreen());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextWithLineHeight(
                              text: forgotPassword,
                              textColor: mainColor,
                              fontWeight: mediumFont,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Consumer<AuthProvider>(
                          builder: (ctx, authProvider, child) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (authProvider.resMessage != '') {
                            customSnackBar(context, authProvider.resMessage);

                            ///Clear the response message to avoid duplicate
                            authProvider.clear();
                          }
                        });
                        return authProvider.isLoading
                            ? const CupertinoActivityIndicator()
                            : MainButton(
                                "Log in",
                                () async {
                                  if (emailController.text.length >= 5 &&
                                      passwordController.text.trim().length >=
                                          8) {
                                    final isLoggedIn =
                                        await authProvider.loginUser(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            context: context);

                                    if (mounted && isLoggedIn) {
                                      navToWithScreenName(
                                          context: context,
                                          isPushAndRemoveUntil: true,
                                          screen: const BottomNavScreen());
                                    }
                                  }
                                },
                              );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: bottomPadding.h,
              )
            ],
          )),
    );
  }
}
