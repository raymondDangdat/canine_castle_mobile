import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../resources/constants/font_constants.dart';

Future showConfirmTransactionPINModal(BuildContext importedContext,
    {required String pin}) {
  final confirmController = TextEditingController();
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(modalRadius.r),
                topRight: Radius.circular(modalRadius.r)),
          ),
          child: Consumer2<WalletProvider, AuthProvider>(
              builder: (ctx, walletProvider, authProvider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.4,
                          maxHeight: MediaQuery.of(context).size.height * 0.6),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(cancel)),
                              const CustomText(
                                text: 'Confirm PIN',
                                textColor: black,
                                fontSize: 16,
                                fontWeight: titleFont,
                              ),
                              Container(),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const BodyTextPrimaryWithLineHeight(
                            text: "Confirm your 4 digit PIN",
                            textColor: Color.fromRGBO(130, 130, 130, 1),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textStyle: const TextStyle(
                                  color: Colors.black, fontWeight: mediumFont),
                              length: 4,
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
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              errorAnimationController:
                                  walletProvider.errorController,
                              controller: confirmController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) async {
                                if (confirmController.text == pin) {
                                  bool pinCreated =
                                      await walletProvider.createPIN(
                                          context: context,
                                          pin: confirmController.text);
                                  authProvider.getProfile(context: context);
                                  if (pinCreated) {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  customSnackBar(context, "Confirm your PIN");
                                }
                                debugPrint("Completed");
                              },
                              onChanged: (value) {
                                debugPrint(value);
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            );
          }));
    },
  );
}
