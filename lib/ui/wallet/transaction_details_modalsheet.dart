import 'package:canine_castle_mobile/ui/wallet/tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/components.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

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
                    text: 'Transaction details',
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
                        text: 'Withdrawal',
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
                leading: 'Recipient bank',
                trailing: 'United bank of africa',
                textColor: black,
              ),
              const TileWidget(
                leading: 'Status',
                trailing: 'Succesful',
                textColor: greenShade2,
              ),
              const TileWidget(
                leading: 'Transaction type',
                trailing: 'Withdrawal',
                textColor: Colors.black,
              ),
              const TileWidget(
                leading: 'Transaction fee',
                trailing: '₦ 0.00',
                textColor: black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 155,
                    height: 50,
                    child: MainButton(
                        'Report an issue',
                        textColor: orangeShade4,
                        color: orangeShade3,
                        fontSize: 14,
                        () {}),
                  ),
                  SizedBox(
                    width: 155,
                    height: 50,
                    child: MainButton('Share', fontSize: 14, () {}),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
