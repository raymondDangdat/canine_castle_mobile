import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';

class EnterPinModalSheet extends StatefulWidget {
  const EnterPinModalSheet({super.key});

  @override
  State<EnterPinModalSheet> createState() => _EnterPinModalSheetState();
}

class _EnterPinModalSheetState extends State<EnterPinModalSheet> {
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(cancel)),
                const Spacer(
                  flex: 4,
                ),
                const CustomText(
                  text: 'Enter pin',
                  textColor: black,
                  fontSize: 16,
                  fontWeight: titleFont,
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            const SizedBox(height: 35),
            const CustomText(
              text: 'Enter a 4 digit pin',
              textColor: ashShade,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(9),
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
                    //  currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            const SizedBox(height: 8),
            const CustomText(
              text: 'Forgot pin?',
              textColor: mainColor,
              fontWeight: mediumFont,
            ),
          ],
        ),
      ),
    );
  }
}
