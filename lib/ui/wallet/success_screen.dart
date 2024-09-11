import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.38),
              child: Column(
                children: [
                  SvgPicture.asset(success),
                  const CustomText(
                    text: 'Success',
                    textColor: black,
                    fontSize: 23,
                    fontWeight: boldFont,
                  ),
                  const CustomText(
                    text: 'You sent a sum of NGN 79,000 to @johndoe',
                    textColor: black,
                    fontWeight: semiBoldFont,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 155,
                  height: 50,
                  child: MainButton(
                      'Report an issue',
                      textColor: orangeShade4,
                      color: orangeShade3,
                      fontSize: 14,
                      () {}),
                ),
                SizedBox(
                  width: 155,
                  height: 50,
                  child: MainButton('Done', fontSize: 14, () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
