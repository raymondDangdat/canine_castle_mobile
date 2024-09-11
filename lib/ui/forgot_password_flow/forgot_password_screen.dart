import 'package:canine_castle_mobile/ui/forgot_password_flow/verify_email_to_change_password_screen.dart';
import 'package:flutter/cupertino.dart';
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
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
          bottom: false,
          child: Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: topPadding.h,
                ),
                const CustomAppbar(title: forgotPasswordd),
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
                              text: enterEmailAddress,
                              textColor: blackTextColor,
                              fontWeight: boldFont,
                              fontSize: 23,
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            CustomTextWithLineHeight(
                              text:
                                  "A verification code will be sent to to your \nmail for verification",
                              textColor: blackTextColor,
                              fontWeight: mediumFont,
                              fontSize: 14,
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
                        SizedBox(
                          height: 24.h,
                        ),
                        authProvider.requestingForgotPassword
                            ? const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : MainButton(
                                continueTo,
                                () async {
                                  if (emailController.text.trim().length > 5) {
                                    authProvider.updateEmailForPasswordReset(
                                        newEmail: emailController.text);
                                    final requested = await authProvider
                                        .forgotPassword(context: context);
                                    if (mounted && requested) {
                                      navToWithScreenName(
                                          context: context,
                                          screen:
                                              const VerifyEmailToChangeScreen());
                                    }
                                  }
                                },
                              )
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
            );
          })),
    );
  }
}
