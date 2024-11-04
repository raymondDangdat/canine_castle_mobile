import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/wallet/modals/verify_pin_modal.dart';
import 'package:canine_castle_mobile/ui/wallet/withdrawal_success_screen.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../widgets/custom_snack_back.dart';
import '../tile_widget.dart';
import 'create_transaction_pin_modal.dart';

Future showWithdrawalSummaryModal(BuildContext importedContext) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(modalRadius.r),
                topRight: Radius.circular(modalRadius.r)),
          ),
          child: Consumer2<WalletProvider, AuthProvider>(
              builder: (ctx, walletProvider, authProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (walletProvider.resMessage != '') {
                customSnackBar(context, walletProvider.resMessage,
                    isError: walletProvider.isError);

                ///Clear the response message to avoid duplicate
                walletProvider.clear();
              }
            });
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.4,
                          maxHeight: MediaQuery.of(context).size.height * 0.65),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(cancel)),
                              const BodyTextPrimaryWithLineHeight(
                                text: 'Summary',
                                textColor: black,
                                fontSize: 16,
                                fontWeight: titleFont,
                              ),
                              Container(),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: orangeShade2,
                              border: Border.all(color: mainColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  const BodyTextPrimaryWithLineHeight(
                                    text: "Withdrawal",
                                    textColor: black,
                                    fontSize: 13,
                                  ),
                                  CustomText(
                                    text:
                                        'NGN ${moneyFormat.format(double.parse(walletProvider.amountController.text.isEmpty ? '00' : walletProvider.amountController.text.replaceAll(",", "")))}',
                                    textColor: const Color(0xFF0C0C0C),
                                    fontSize: 25,
                                    fontWeight: boldFont,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TileWidget(
                            leading: 'Recipient name ',
                            trailing:
                                '${walletProvider.selectedBankAccount?.accountName}',
                            textColor: black,
                          ),
                          TileWidget(
                            leading: 'Recipient bank',
                            trailing:
                                '${walletProvider.selectedBankAccount?.bankName}',
                            textColor: black,
                          ),
                          const TileWidget(
                            leading: 'Transaction type',
                            trailing: 'Wallet Withdrawal',
                            textColor: Colors.black,
                          ),
                          const TileWidget(
                            leading: 'Transaction fee',
                            trailing: '₦ 0.00',
                            textColor: black,
                          ),
                          SizedBox(
                            height: 27.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: walletProvider.withdrawing
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : MainButton('Withdraw', fontSize: 14,
                                          () async {
                                          if (authProvider
                                                  .userProfile
                                                  ?.data
                                                  .details
                                                  .relationships
                                                  .transactionPin ==
                                              true) {
                                            final pin =
                                                await showVerifyTransactionPINModal(
                                                    importedContext);
                                            if (pin != null) {
                                              bool fundWithdrawn =
                                                  await walletProvider
                                                      .withdrawFromWallet(
                                                          context: context,
                                                          pin: pin);
                                              if (fundWithdrawn) {
                                                walletProvider.getTransactions(
                                                    context: context);
                                                Navigator.pop(context);
                                                navToWithScreenName(
                                                    context: context,
                                                    screen:
                                                        const WithdrawalSuccessScreen());
                                              } else {
                                                walletProvider.getTransactions(
                                                    context: context);
                                              }
                                            }
                                          } else {
                                            showCreateTransactionPINlModal(
                                                context);
                                          }
                                        })),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            );
          }));
    },
  );
}
