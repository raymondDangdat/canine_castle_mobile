import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/ui/wallet/add_money_screen.dart';
import 'package:canine_castle_mobile/ui/wallet/modals/transaction_detail_modal.dart';
import 'package:canine_castle_mobile/ui/wallet/transfer_screen.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/long_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_text.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<AuthProvider, WalletProvider>(
            builder: (ctx, authProvider, walletProver, child) {
          return Column(
            children: [
              const TopPadding(),
              const CustomAppbar(title: wallet),
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
                              image: AssetImage(walletBalance),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(balanceIcon),
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
                                              text: !walletProver.showBalance
                                                  ? "*******"
                                                  : moneyFormat.format(
                                                      double.parse(authProvider
                                                                  .userProfile
                                                                  ?.data
                                                                  .wallet
                                                                  .balance ==
                                                              null
                                                          ? "0.00"
                                                          : authProvider
                                                              .userProfile!
                                                              .data
                                                              .wallet
                                                              .balance
                                                              .toString())),
                                              textColor: white,
                                              fontSize: 23,
                                              fontWeight: boldFont,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          walletProver.toggleShowBalance();
                                        },
                                        child: Image.asset(eyeIcon)),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                CustomContainerButton(
                                  onTap: () {},
                                  title: "",
                                  bgColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: 23,
                                  widget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const BodyTextPrimaryWithLineHeight(
                                            text: "Wallet tag ",
                                            textColor:
                                                Color.fromRGBO(76, 54, 35, 1),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "${authProvider.userProfile?.data.wallet.tag}",
                                            textColor: const Color.fromRGBO(
                                                76, 54, 35, 1),
                                            fontWeight: boldFont,
                                          )
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            copyToClipboard(
                                                "${authProvider.userProfile?.data.wallet.tag}");
                                          },
                                          child: SvgPicture.asset(copyTagIcon))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                walletProver.amountController.text = "";
                                walletProver.walletTagController.text = "";
                                navToWithScreenName(
                                    context: context,
                                    screen: const TransferScreen());
                              },
                              child: SvgPicture.asset(transferIcon)),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                walletProver.amountController.text = "";
                                navToWithScreenName(
                                    context: context,
                                    screen: const AddMoneyScreen());
                              },
                              child: SvgPicture.asset(addMoney)),
                          const Spacer(),
                          InkWell(
                              onTap: () {}, child: SvgPicture.asset(withdraw)),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: mainGrey,
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: const CustomText(
                          text: 'Transaction history',
                          textColor: foundation,
                          fontWeight: semiBoldFont,
                        ),
                      ),
                      walletProver.gettingTransactions
                          ? Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: const CupertinoActivityIndicator(),
                            )
                          : walletProver.allTransactions.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: BodyTextPrimaryWithLineHeight(
                                    text: "No Transactions",
                                    fontWeight: semiBoldFont,
                                    textColor: black,
                                    fontSize: 20,
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      walletProver.allTransactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction =
                                        walletProver.allTransactions[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          walletProver
                                              .updateSelectedTransaction(
                                                  transaction);
                                          showTransactionDetailModal(context);
                                        },
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: CustomText(
                                                text: transaction.description,
                                                textColor: black,
                                                fontWeight: mediumFont,
                                              ),
                                              subtitle: CustomText(
                                                text: transaction.createdAt
                                                    .toString(),
                                                textColor: ash,
                                                fontSize: 11,
                                                fontWeight: mediumFont,
                                              ),
                                              trailing: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        "${transaction.type == "CREDIT" ? '+' : '-'} $nairaSign${moneyFormat.format(transaction.amount)}",
                                                    textColor: transaction
                                                                .type ==
                                                            "CREDIT"
                                                        ? const Color.fromRGBO(
                                                            29, 134, 52, 1)
                                                        : const Color.fromRGBO(
                                                            226, 7, 7, 1),
                                                    fontWeight: semiBoldFont,
                                                  ),
                                                  CustomText(
                                                    text: transaction.status
                                                        .toString()
                                                        .capitalize(),
                                                    textColor: transaction
                                                                .status
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "SUCCESSFUL"
                                                                .toLowerCase()
                                                        ? const Color.fromRGBO(
                                                            29, 134, 52, 1)
                                                        : mainColor,
                                                    fontWeight: semiBoldFont,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const LongDivider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
