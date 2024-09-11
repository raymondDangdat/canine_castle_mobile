import 'package:canine_castle_mobile/ui/wallet/transaction_summary_modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../widgets/label_widget.dart';
import '../../widgets/textfields.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final usernameController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(arrowHeadBack)),
                    const Spacer(),
                    const CustomText(
                      text: 'Transfer',
                      textColor: black,
                      fontSize: 16,
                      fontWeight: mediumFont,
                    ),
                    const Spacer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SvgPicture.asset(line),
                ),
                const LabelWidget(
                  label: 'Enter recipients username',
                  textColor: ashShade,
                  fontSize: 13,
                  fontWeight: mediumFont,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomField(
                        "johndoe",
                        usernameController,
                        isCapitalizeSentence: false,
                        type: TextInputType.text,
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
                        label: 'Wallet Bal',
                        textColor: ashShade,
                        fontSize: 11,
                        fontWeight: semiBoldFont,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 6.0),
                      child: SvgPicture.asset(naira2),
                    ),
                    const LabelWidget(
                      label: '400,000',
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
                        amountController,
                        isCapitalizeSentence: false,
                        type: TextInputType.number,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: MainButton(
              'Next',
              () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const TransactionSummaryModalSheet(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
