import 'package:canine_castle_mobile/ui/wallet/transaction_details_modalsheet.dart';
import 'package:canine_castle_mobile/ui/wallet/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/custom_text.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/navigation_utils.dart';
import 'dummy_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(arrowHeadBack)),
                  const Spacer(),
                  const CustomText(
                    text: 'Wallet',
                    textColor: black,
                    fontSize: 16,
                    fontWeight: mediumFont,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SvgPicture.asset(line),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 112,
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
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(balanceIcon),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, right: 5),
                                child: SvgPicture.asset(naira),
                              ),
                              const CustomText(
                                text: '60,000',
                                textColor: white,
                                fontSize: 23,
                                fontWeight: boldFont,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(eyeIcon),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                InkWell(
                    onTap: () {
                      navToWithScreenName(
                          context: context, screen: const TransferScreen());
                    },
                    child: SvgPicture.asset(transfer)),
                const Spacer(),
                SvgPicture.asset(addMoney),
                const Spacer(),
                SvgPicture.asset(withdraw),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: walletData.length,
              itemBuilder: (context, index) {
                final data = walletData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const TransactionDetails(),
                      );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircleAvatar(child: Image.asset(data.pic)),
                          ),
                          title: CustomText(
                            text: data.title,
                            textColor: black,
                            fontWeight: mediumFont,
                          ),
                          subtitle: CustomText(
                            text: data.subtitle,
                            textColor: ash,
                            fontSize: 11,
                            fontWeight: mediumFont,
                          ),
                          trailing: CustomText(
                            text: data.amount,
                            textColor: data.colorStatus,
                            fontWeight: semiBoldFont,
                          ),
                        ),
                        SvgPicture.asset(line),
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
    );
  }
}
