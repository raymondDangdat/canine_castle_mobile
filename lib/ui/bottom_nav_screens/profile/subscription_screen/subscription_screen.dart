import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<AuthProvider, WalletProvider>(
            builder: (ctx, authProvider, walletProver, child) {
          return Column(
            children: [
              const TopPadding(),
              const CustomAppbar(title: subscription),
              SvgPicture.asset(line),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding.w),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(subscriptionBg),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BodyTextPrimaryWithLineHeight(
                                          text: "Canine Castle Premium",
                                          textColor:
                                              Color.fromRGBO(204, 204, 204, 1),
                                          fontSize: 13,
                                          fontWeight: mediumFont,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3, right: 5),
                                              child: SvgPicture.asset(naira),
                                            ),
                                            BodyTextPrimaryWithLineHeight(
                                              text: "",
                                              textColor: white,
                                              fontSize: 23,
                                              fontWeight: boldFont,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
