import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/long_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../Widgets/custom_text.dart';
import '../../providers/wallet_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/string_constants.dart';
import '../../utils/constants.dart';
import 'modals/transaction_detail_modal.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<WalletProvider>(builder: (ctx, walletProver, child) {
        return Column(
          children: [
            const TopPadding(),
            const CustomAppbar(title: "Transaction history"),
            SizedBox(
              height: 20.h,
            ),
            walletProver.gettingTransactions
                ? Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: const Center(child: CupertinoActivityIndicator()),
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
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: walletProver.allTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                walletProver.allTransactions[index];
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: horizontalPadding.w,
                                    right: horizontalPadding.w,
                                    bottom: 16),
                                child: InkWell(
                                  onTap: () {
                                    walletProver
                                        .updateSelectedTransaction(transaction);
                                    showTransactionDetailModal(context);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(transaction.type ==
                                                  creditTransactionType
                                              ? depositTransactionIcon
                                              : debitTransactionIcon),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BodyTextPrimaryWithLineHeight(
                                                text: transaction.description,
                                                textColor: black,
                                                maxLines: 1,
                                                fontWeight: mediumFont,
                                              ),
                                              CustomText(
                                                text: transaction.createdAt
                                                    .toString(),
                                                textColor: ash,
                                                fontSize: 11,
                                                fontWeight: mediumFont,
                                              ),
                                            ],
                                          )),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            text:
                                                "${transaction.type == "CREDIT" ? '+' : '-'} $nairaSign${moneyFormat.format(transaction.amount)}",
                                            textColor: transaction.type ==
                                                    creditTransactionType
                                                ? const Color.fromRGBO(
                                                    29, 134, 52, 1)
                                                : const Color.fromRGBO(
                                                    226, 7, 7, 1),
                                            fontWeight: semiBoldFont,
                                          )
                                        ],
                                      ),
                                      const LongDivider(),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
          ],
        );
      })),
    );
  }
}
