import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/wallet/withdraw_money_screen.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../utils/functions.dart';
import '../../../widgets/custom_vertical_divider_widget.dart';
import '../../../widgets/pull_down_indicator.dart';

Future showSelectBankAccountModal(
  BuildContext importedContext,
) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child:
              Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
            return Container(
                margin: EdgeInsets.only(bottom: bottomPadding.h, top: 14.h),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(modalRadius.r),
                      topRight: Radius.circular(modalRadius.r)),
                ),
                child: Wrap(
                  children: <Widget>[
                    SizedBox(height: 14.h),
                    const Center(child: PullDownIndicator()),
                    SizedBox(
                      height: 19.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BodyTextLightWithLineHeight(
                            text: "Withdraw money",
                            textColor: blackTextColor,
                            fontSize: 16,
                            fontWeight: semiBoldFont,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(closeIconSvg)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: const BodyTextPrimaryWithLineHeight(
                        text: "Select an account you are withdrawing to",
                        fontSize: 13,
                        textColor: Color.fromRGBO(98, 98, 98, 1),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                          minHeight: MediaQuery.of(context).size.height * 0.2),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ListView.builder(
                            itemCount: walletProvider.allBankAccounts.length,
                            itemBuilder: (context, index) {
                              final account =
                                  walletProvider.allBankAccounts[index];
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index <
                                              walletProvider
                                                      .allBankAccounts.length -
                                                  1
                                          ? 16.h
                                          : 0,
                                      left: horizontalPadding.w,
                                      right: horizontalPadding.w),
                                  child: CustomContainerButton(
                                    onTap: () {
                                      walletProvider
                                          .updateSelectedBankAccount(account);
                                    },
                                    borderColor:
                                        walletProvider.selectedBankAccount ==
                                                account
                                            ? mainColor
                                            : const Color(0xFFCCCCCC),
                                    title: "",
                                    borderRadius: 12,
                                    widget: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(bankAccountIcon),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BodyTextPrimaryWithLineHeight(
                                                    text:
                                                        maskAccountNumberString(
                                                            account
                                                                .accountNumber),
                                                    textColor:
                                                        const Color(0xFF0A0A0B),
                                                    fontWeight: semiBoldFont,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      BodyTextPrimaryWithLineHeight(
                                                        text:
                                                            account.accountName,
                                                        textColor: const Color(
                                                            0xFF0A0A0B),
                                                        fontWeight:
                                                            semiBoldFont,
                                                        fontSize: 13,
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5),
                                                        child:
                                                            CustomVerticalDividerWidget(),
                                                      ),
                                                      Expanded(
                                                        child:
                                                            BodyTextPrimaryWithLineHeight(
                                                          text:
                                                              account.bankName,
                                                          textColor:
                                                              const Color(
                                                                  0xFF0A0A0B),
                                                          fontWeight:
                                                              semiBoldFont,
                                                          fontSize: 13,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                        SvgPicture.asset(account ==
                                                walletProvider
                                                    .selectedBankAccount
                                            ? checkedIconSvg
                                            : uncheckedIconSvg)
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                      child: MainButton(continueTo, () {
                        if (walletProvider.selectedBankAccount == null) {
                          customSnackBar(
                              context, "Select an account to withdraw into");
                        } else {
                          Navigator.pop(context);
                          navToWithScreenName(
                              context: context,
                              screen: const WithdrawMoneyScreen());
                        }
                      }),
                    ),
                    SizedBox(
                      height: bottomPadding.h,
                    ),
                  ],
                ));
          }));
    },
  );
}
