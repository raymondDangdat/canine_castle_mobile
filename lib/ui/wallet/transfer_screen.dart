import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/ui/wallet/modals/create_transaction_pin_modal.dart';
import 'package:canine_castle_mobile/ui/wallet/transfer_summary_modal.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Widgets/components.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<AuthProvider, WalletProvider>(
            builder: (ctx, authProvider, walletProver, child) {
          return Column(
            children: [
              const TopPadding(),
              const CustomAppbar(title: transfer),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const LabelWidget(
                        label: 'Enter recipients wallet tag',
                        textColor: ashShade,
                        fontSize: 13,
                        fontWeight: mediumFont,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomField(
                              "CC277615427",
                              walletProver.walletTagController,
                              isCapitalizeSentence: false,
                              type: TextInputType.text,
                              onChange: (value) {
                                if (value != null && value.length >= 12) {
                                  walletProver.retrieveUserDetailsFromWalletTag(
                                      context: context);
                                }
                              },
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 12, top: 13),
                                child: Text("@"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const LabelWidget(
                            label: 'Enter amount',
                            textColor: ashShade,
                            fontSize: 13,
                            fontWeight: mediumFont,
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: LabelWidget(
                              label: 'Wallet Balance',
                              textColor: ashShade,
                              fontSize: 11,
                              fontWeight: semiBoldFont,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 5, bottom: 6.0),
                            child: SvgPicture.asset(naira2),
                          ),
                          LabelWidget(
                            label: moneyFormat.format(double.parse(authProvider
                                .userProfile!.data.wallet.balance
                                .toString())),
                            textColor: ashShade,
                            fontSize: 11,
                            fontWeight: semiBoldFont,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomField(
                              "1000",
                              walletProver.amountController,
                              isCapitalizeSentence: false,
                              type: TextInputType.number,
                              onChange: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    var text = NumberFormat.decimalPattern('en')
                                        .format(int.parse(
                                            value.replaceAll(',', '')));
                                    walletProver.amountController.value =
                                        TextEditingValue(
                                      text: text,
                                      selection: TextSelection.collapsed(
                                        offset: text.length,
                                      ),
                                    );
                                  }
                                  setState(() {});
                                }
                              },
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 12, top: 13),
                                child: Text("₦"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: topPadding.h),
                child: MainButton(
                  next,
                  () {
                    if (walletProver.walletTagController.text.isEmpty) {
                      customSnackBar(context, "Enter a valid wallet tag");
                    } else if (walletProver.amountController.text.isEmpty) {
                      customSnackBar(context, "Enter a valid amount");
                    } else {
                      if (authProvider.userProfile?.data.details.relationships
                              .transactionPin ==
                          true) {
                        showTransferSummaryModal(context);
                      } else {
                        showCreateTransactionPINlModal(context);
                      }
                    }
                  },
                ),
              ),
              // SizedBox(height: bottomPadding.h,),
            ],
          );
        }),
      ),
    );
  }
}
