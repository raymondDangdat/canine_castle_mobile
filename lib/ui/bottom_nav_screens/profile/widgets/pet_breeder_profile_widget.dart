import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/logout_button_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/profile_item_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/section_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/user_info_widget.dart';
import 'package:canine_castle_mobile/ui/manage_canines/my_canines_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Widgets/custom_text.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/navigation_utils.dart';
import '../../../wallet/wallet_screen.dart';
import '../subscription_screen/subscription_screen.dart';

class PetBreederProfileWidget extends StatelessWidget {
  const PetBreederProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //padding: EdgeInsets.all(20),
      child: Consumer2<AuthProvider, WalletProvider>(
          builder: (ctx, authProvider, walletProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  const SizedBox(height: 30),
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
            const UserInfoWidget(),
            const SectionWidget(
              sectionName: "Manage",
            ),
            ProfileItemWidget(
                onTap: () {
                  authProvider.getProfile(context: context);
                  walletProvider.getTransactions(context: context);
                  navToWithScreenName(
                      context: context, screen: const WalletScreen());
                },
                title: "Wallet",
                iconName: walletIcon),

            ProfileItemWidget(
                onTap: () {
                  navToWithScreenName(
                      context: context, screen: const MyCanineScreen());
                },
                title: manageCanines,
                iconName: petIcon),
            ProfileItemWidget(
                onTap: () {
                  walletProvider.getSubscriptionPlans(context: context);
                  navToWithScreenName(
                      context: context, screen: const SubscriptionScreen());
                },
                title: subscription,
                iconName: subscriptionIcon),

            const SectionWidget(sectionName: "Other"),
            ProfileItemWidget(onTap: () {}, title: favorite, iconName: favIcon),
            ProfileItemWidget(
                onTap: () {}, title: notifications, iconName: notificationIcon),
            ProfileItemWidget(onTap: () {}, title: security, iconName: secIcon),
            ProfileItemWidget(
                onTap: () {},
                title: customerSupport,
                iconName: customerSupportIcon),
            ProfileItemWidget(onTap: () {}, title: faq, iconName: msgIcon),
            ProfileItemWidget(
                onTap: () {}, title: legalTerms, iconName: docIcon),
            const SizedBox(
              height: 20,
            ),
            const LogoutButtonWidget(),
          ],
        );
      }),
    );
  }
}
