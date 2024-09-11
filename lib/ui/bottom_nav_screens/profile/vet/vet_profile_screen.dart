import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/vet/user_profile_vet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/navigation_utils.dart';

class VetProfileScreen extends StatelessWidget {
  const VetProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 60),
              child: CustomText(
                text: 'User Profile',
                textColor: black,
                fontSize: 18,
                fontWeight: mediumFont,
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                navToWithScreenName(
                    context: context, screen: const UserProfileVet());
              },
              child: ListTile(
                leading: const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: brown,
                    child: CustomText(
                      text: 'JD',
                      fontSize: 20,
                      fontWeight: semiBoldFont,
                      textColor: white,
                    ),
                  ),
                ),
                title: const CustomText(
                  text: 'John Doe',
                  textColor: black,
                  fontWeight: mediumFont,
                  fontSize: 16,
                ),
                subtitle: const CustomText(
                  text: '@johndoe',
                  textColor: foundation,
                  fontSize: 13,
                  fontWeight: mediumFont,
                ),
                trailing: SvgPicture.asset(arrowIcon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Switch to Pet owner account',
                    textColor: blackTextColor,
                    fontSize: 16,
                    fontWeight: mediumFont,
                  ),
                  SvgPicture.asset(switchOff),
                ],
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: mainGrey,
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: const CustomText(
                text: 'Shop',
                textColor: foundation,
                fontSize: 13,
                fontWeight: mediumFont,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(walletIcon),
              title: const CustomText(
                text: 'Wallet',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            SvgPicture.asset(line),
            ListTile(
              leading: SvgPicture.asset(petIcon),
              title: const CustomText(
                text: 'Manage Canines',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: mainGrey,
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: const CustomText(
                text: 'Others',
                textColor: foundation,
                fontSize: 13,
                fontWeight: mediumFont,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(favIcon),
              title: const CustomText(
                text: 'Favorites',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            SvgPicture.asset(line),
            ListTile(
              leading: SvgPicture.asset(secIcon),
              title: const CustomText(
                text: 'Security',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            SvgPicture.asset(line),
            ListTile(
              leading: SvgPicture.asset(msgIcon),
              title: const CustomText(
                text: 'FAQs',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            SvgPicture.asset(line),
            ListTile(
              leading: SvgPicture.asset(docIcon),
              title: const CustomText(
                text: 'Legal terms',
                textColor: blackTextColor,
                fontSize: 16,
                fontWeight: mediumFont,
              ),
              trailing: SvgPicture.asset(arrowIcon),
            ),
            const SizedBox(height: 10),
            const Center(
              child: CustomText(
                text: 'Log out',
                textColor: red,
                fontWeight: semiBoldFont,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
