import 'package:canine_castle_mobile/ui/wallet/success_screen.dart';
import 'package:canine_castle_mobile/ui/wallet/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/navigation_utils.dart';

class TransactionSummaryModalSheet extends StatelessWidget {
  const TransactionSummaryModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(cancel)),
                  const Spacer(
                    flex: 4,
                  ),
                  const CustomText(
                    text: 'Summary',
                    textColor: black,
                    fontSize: 16,
                    fontWeight: titleFont,
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 96,
                decoration: const BoxDecoration(
                  color: orangeShade2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Wallet transfer',
                        textColor: black,
                        fontSize: 13,
                      ),
                      CustomText(
                        text: 'NGN 79,000',
                        textColor: black,
                        fontSize: 25,
                        fontWeight: boldFont,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const TileWidget(
                leading: 'Recipient name ',
                trailing: 'Chukwueze John Doe (@johndoe)',
                textColor: black,
              ),
              const TileWidget(
                leading: 'Amount to send',
                trailing: '79,000',
                textColor: black,
              ),
              const TileWidget(
                leading: 'Transaction type',
                trailing: 'Wallet transfer',
                textColor: black,
              ),
              const TileWidget(
                leading: 'Transaction fee',
                trailing: '₦ 0.00',
                textColor: black,
              ),
              MainButton('Make transfer', fontSize: 14, () {
                navToWithScreenName(
                    context: context, screen: const SuccessScreen());
              }),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
