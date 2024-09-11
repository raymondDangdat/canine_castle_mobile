import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class UserProfileVet extends StatelessWidget {
  const UserProfileVet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(arrowHeadBack)),
                ),
                const CustomText(
                  text: 'User Profile',
                  textColor: black,
                  fontSize: 16,
                  fontWeight: mediumFont,
                ),
              ],
            ),
            const SizedBox(height: 18),
            SvgPicture.asset(line),
            const SizedBox(height: 18),
            SvgPicture.asset(cimgIcon),
            const SizedBox(height: 18),
            const CustomText(
              text: 'Profile picture',
              textColor: Colors.black,
              fontSize: 12,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: mainGrey),
                color: mainGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Name',
                          textColor: Color.fromRGBO(76, 76, 76, 1),
                        ),
                        CustomText(
                          text: 'John Niyon',
                          textColor: blackTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(line),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Username',
                          textColor: Color.fromRGBO(76, 76, 76, 1),
                        ),
                        Row(
                          children: [
                            const CustomText(
                              text: '@johnniy',
                              textColor: blackTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            SvgPicture.asset(copy)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(line),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Email',
                          textColor: Color.fromRGBO(76, 76, 76, 1),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(verify),
                            const SizedBox(width: 7),
                            const CustomText(
                              text: 'jo*@gmail.com',
                              textColor: blackTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(line),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Phone number',
                          textColor: Color.fromRGBO(76, 76, 76, 1),
                        ),
                        CustomText(
                          text: '+234 (0) 8023455678',
                          textColor: blackTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Center(
              child: CustomText(
                text: 'Delete Account',
                textColor: red,
                fontWeight: semiBoldFont,
              ),
            )
          ],
        ),
      ),
    );
  }
}
