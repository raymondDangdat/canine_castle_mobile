import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../Widgets/components.dart';
import '../../../resources/constants/font_constants.dart';
import '../tile_widget.dart';

Future showTransactionDetailModal(BuildContext importedContext) {
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
          child:
              Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
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
                              const CustomText(
                                text: 'Transaction details',
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
                            decoration:  BoxDecoration(
                              color: orangeShade2,
                              border: Border.all(
                                color: mainColor
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20
                              ),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: walletProvider.selectedTransaction?.type ?? "",
                                    textColor: black,
                                    fontSize: 13,
                                  ),
                                  CustomText(
                                    text: 'NGN ${moneyFormat.format(double.parse(walletProvider.selectedTransaction?.amount == null ? '00' : walletProvider.selectedTransaction!.amount.toString()))}',
                                    textColor: walletProvider.selectedTransaction?.type.toString() == creditTransactionType ? black : red,
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
                            trailing: 'Successful',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child:
                                      MainButton('Share', fontSize: 14, () {})),
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
