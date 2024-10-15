import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(cancel)),
                                const CustomText(
                                  text: 'Summary',
                                  textColor: black,
                                  fontSize: 16,
                                  fontWeight: titleFont,
                                ),
                                Container(),
                              ],
                            ),
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
