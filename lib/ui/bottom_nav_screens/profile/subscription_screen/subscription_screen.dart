import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/long_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/custom_snack_back.dart';
import '../../../wallet/modals/create_transaction_pin_modal.dart';
import '../../../wallet/modals/verify_pin_modal.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<WalletProvider, AuthProvider>(
            builder: (ctx, walletProver, authProvider, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (walletProver.resMessage != '') {
              customSnackBar(context, walletProver.resMessage,
                  isError: walletProver.isError);

              ///Clear the response message to avoid duplicate
              walletProver.clear();
            }
          });
          return Column(
            children: [
              const TopPadding(),
              const CustomAppbar(title: subscription),
              const SizedBox(height: 20),
              Expanded(
                child: walletProver.gettingSubscription
                    ? const CupertinoActivityIndicator()
                    : walletProver.subscriptionPlans.isEmpty
                        ? const BodyTextPrimaryWithLineHeight(
                            text: "No Plans Available yet")
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding.w),
                            child: ListView.builder(
                                itemCount:
                                    walletProver.subscriptionPlans.length,
                                itemBuilder: (context, index) {
                                  final plan =
                                      walletProver.subscriptionPlans[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: InkWell(
                                      onTap: () {
                                        walletProver.updateSelectedPlan(plan);
                                      },
                                      child: Container(
                                        // padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: walletProver
                                                                .selectedPlan ==
                                                            plan ||
                                                        authProvider
                                                                .userProfile
                                                                ?.data
                                                                .details
                                                                .relationships
                                                                .subscription
                                                                .plan
                                                                .id
                                                                .toString() ==
                                                            plan.id.toString()
                                                    ? mainColor
                                                    : const Color.fromRGBO(
                                                        230, 230, 230, 1))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          planIcon),
                                                      SizedBox(
                                                        width: 14.w,
                                                      ),
                                                      BodyTextPrimaryWithLineHeight(
                                                        text: plan.name ?? "",
                                                        textColor: const Color(
                                                            0xFF0C0C0C),
                                                        fontWeight: mediumFont,
                                                      ),
                                                    ],
                                                  ),
                                                  SvgPicture.asset(walletProver
                                                                  .selectedPlan ==
                                                              plan ||
                                                          authProvider
                                                                  .userProfile
                                                                  ?.data
                                                                  .details
                                                                  .relationships
                                                                  .subscription
                                                                  .plan
                                                                  .id
                                                                  .toString() ==
                                                              plan.id.toString()
                                                      ? checkedIconSvg
                                                      : uncheckedIconSvg)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            const LongDivider(),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            if (authProvider
                                                    .userProfile
                                                    ?.data
                                                    .details
                                                    .relationships
                                                    .subscription
                                                    .plan
                                                    .id
                                                    .toString() ==
                                                plan.id.toString())
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    bottom: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomContainerButton(
                                                      onTap: () {},
                                                      title: "Current plan",
                                                      borderRadius: 16,
                                                      verticalPadding: 8,
                                                      textColor: mainColor,
                                                      bgColor:
                                                          const Color.fromRGBO(
                                                              251, 245, 240, 1),
                                                    ),
                                                    BodyTextPrimaryWithLineHeight(
                                                      text: authProvider
                                                              .userProfile
                                                              ?.data
                                                              .details
                                                              .relationships
                                                              .subscription
                                                              .isActive
                                                          ? "Expires on ${returnFormattedDate(authProvider.userProfile?.data.details.relationships.subscription.endDate)}"
                                                          : "Expired",
                                                      textColor:
                                                          const Color.fromRGBO(
                                                              76, 76, 76, 1),
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      horizontalPadding.w),
                                              child: Row(
                                                children: [
                                                  BodyTextPrimaryWithLineHeight(
                                                    text:
                                                        "$nairaSign${returnFormattedAmount(amount: plan.cost.toString())}",
                                                    textColor:
                                                        const Color(0xFF0C0C0C),
                                                    fontSize: 23,
                                                    fontWeight: semiBoldFont,
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  const BodyTextPrimaryWithLineHeight(
                                                      text: "per year",
                                                      textColor:
                                                          Color(0xFF626262),
                                                      fontSize: 13),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      horizontalPadding.w),
                                              child: const Row(
                                                children: [
                                                  BodyTextPrimaryWithLineHeight(
                                                      text: "Benefits",
                                                      textColor:
                                                          Color(0xFF4C4C4C),
                                                      fontSize: 13),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      plan.features.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final feature =
                                                        plan.features[index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SvgPicture.asset(
                                                              subPlanFeatureIcon),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            child: BodyTextPrimaryWithLineHeight(
                                                                text: feature,
                                                                textColor:
                                                                    const Color(
                                                                        0xFF4C4C4C),
                                                                fontSize: 13),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
              ),
              if (!walletProver.gettingSubscription &&
                  walletProver.selectedPlan != null)
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: walletProver.activatingSubscription
                      ? const Center(child: CupertinoActivityIndicator())
                      : MainButton(
                          "Subscribe to ${walletProver.selectedPlan?.name} Plan",
                          () async {
                          if (authProvider.userProfile?.data.details
                                  .relationships.transactionPin ==
                              true) {
                            final pin =
                                await showVerifyTransactionPINModal(context);
                            if (pin != null) {
                              bool subscribed =
                                  await walletProver.activateSubscription(
                                      context: context, pin: pin);
                              authProvider.getProfile(context: context);
                              if (subscribed) {
                                customSnackBar(
                                    context, "Subscribed successfully",
                                    isError: false);
                              }
                            }
                          } else {
                            bool passwordSet =
                                await showCreateTransactionPINlModal(context);
                          }
                        }),
                )
            ],
          );
        }),
      ),
    );
  }
}
