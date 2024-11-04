import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/wallet/payment_screen.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
          return Column(
            children: [
              TopPadding(),
              const CustomAppbar(title: "Add money"),
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
                      CustomContainerButton(
                        onTap: () {},
                        title: "",
                        borderRadius: 12,
                        bgColor: const Color(0xFFF9F9F9),
                        widget: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyTextPrimaryWithLineHeight(
                                  text: "Service charge",
                                  textColor: Color(0xFF626262),
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: "NGN 0.00",
                                  textColor: Color(0xFF626262),
                                  fontWeight: mediumFont,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 48.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const BodyTextPrimaryWithLineHeight(
                                  text: "Total",
                                  textColor: Color(0xFF626262),
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text:
                                      "NGN ${walletProvider.amountController.text.isEmpty ? '0.00' : walletProvider.amountController.text}",
                                  textColor: const Color(0xFF1B1A1A),
                                  fontWeight: boldFont,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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
                            'Pay NGN ${walletProvider.amountController.text.isEmpty ? '000' : walletProvider.amountController.text}',
                            () async {
                              if (double.parse(walletProvider
                                      .amountController.text
                                      .replaceAll(",", "")) >=
                                  100) {
                                bool isInitialized = await walletProvider
                                    .initializePayment(context: context);
                                if (isInitialized &&
                                    walletProvider
                                            .initializePaymentModel?.data.url !=
                                        null) {
                                  navToWithScreenName(
                                      context: context,
                                      screen: const PaymentScreen());
                                }
                              }
                            },
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(lockIcon),
                        SizedBox(
                          width: 3.w,
                        ),
                        const BodyTextPrimaryWithLineHeight(
                          text: "All payments are secured  with Paystack",
                          fontSize: 13,
                          textColor: Color(0xFF4C4C4C),
                        )
                      ],
                    )
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
