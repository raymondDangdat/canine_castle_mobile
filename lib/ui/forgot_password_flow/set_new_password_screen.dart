import 'package:canine_castle_mobile/ui/forgot_password_flow/password_changed_successfully_screen.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
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
import '../../widgets/custom_snack_back.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: topPadding.h,
              ),
              const CustomAppbar(title: forgotPasswordd),
              SizedBox(
                height: 32.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          CustomTextWithLineHeight(
                            text: resetPassword,
                            textColor: blackTextColor,
                            fontWeight: boldFont,
                            fontSize: 23,
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          CustomTextWithLineHeight(
                            text: enterANewPassword,
                            textColor: blackTextColor,
                            fontWeight: mediumFont,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const LabelWidget(label: newPassword),
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
                        height: 16.h,
                      ),
                      const LabelWidget(label: confirmPassword),
                      PwdField(
                        hint: "Confirm your password",
                        controller: confirmPasswordController,
                        isObscured: obscure,
                        hasBorder: true,
                        onTap: () {
                          setState(() => obscure = !obscure);
                        },
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
                        return authProvider.resettingPassword
                            ? const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : MainButton(
                                continueTo,
                                () async {
                                  if (passwordController.text.trim().length <
                                      8) {
                                    customSnackBar(context,
                                        "Password must be at least 8 characters");
                                  } else if (passwordController.text.trim() !=
                                      confirmPasswordController.text.trim()) {
                                    customSnackBar(
                                        context, "Password mismatch");
                                  } else if (!passwordController.text
                                      .isValidPassword()) {
                                    customSnackBar(context,
                                        "Password must contain at least one uppercase letter, one lowercase letter, one numeric digit, and one special character.");
                                  } else {
                                    if (!authProvider.resettingPassword) {
                                      final passwordReset =
                                          await authProvider.resetPassword(
                                              context: context,
                                              newPassword:
                                                  passwordController.text);
                                      if (mounted && passwordReset) {
                                        navToWithScreenName(
                                            context: context,
                                            isPushAndRemoveUntil: true,
                                            screen:
                                                const PasswordChangedSuccessfullyScreen());
                                      }
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
