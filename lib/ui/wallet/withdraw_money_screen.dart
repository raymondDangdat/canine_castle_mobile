import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Widgets/components.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';
import 'modals/withdrawal_summary_modal.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({super.key});

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
          return Column(
            children: [
              const TopPadding(),
              const CustomAppbar(title: "Withdraw money"),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    children: [
                      const LabelWidget(
                        label: 'Enter amount',
                        textColor: ashShade,
                        fontSize: 13,
                        fontWeight: mediumFont,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomField(
                              "50,00",
                              walletProvider.amountController,
                              isCapitalizeSentence: false,
                              type: const TextInputType.numberWithOptions(
                                  signed: true),
                              formatters: numbersOnlyFormat,
                              onChange: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    var text = NumberFormat.decimalPattern('en')
                                        .format(int.parse(
                                            value.replaceAll(',', '')));

                                    walletProvider.amountController.value =
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
                                child: Text("$nairaSign"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding.w,
                ),
                child: Column(
                  children: [
                    walletProvider.initializingPayment
                        ? const CupertinoActivityIndicator()
                        : MainButton(
                            'Withdraw NGN ${walletProvider.amountController.text.isEmpty ? '000' : walletProvider.amountController.text}',
                            () async {
                              if (walletProvider.amountController.text
                                      .replaceAll(",", "")
                                      .isEmpty ||
                                  double.parse(walletProvider
                                          .amountController.text
                                          .replaceAll(",", "")) <
                                      100) {
                                customSnackBar(context,
                                    "Please enter an amount from $nairaSign\100 and above");
                              } else {
                                showWithdrawalSummaryModal(context);
                              }
                            },
                          ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
