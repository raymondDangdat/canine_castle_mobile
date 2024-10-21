import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/ui/wallet/modals/verify_pin_modal.dart';
import 'package:canine_castle_mobile/ui/wallet/tile_widget.dart';
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
import '../../widgets/custom_snack_back.dart';

Future showTransferSummaryModal(BuildContext importedContext) {
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
                customSnackBar(context, walletProvider.resMessage);

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
                          maxHeight: MediaQuery.of(context).size.height * 0.59),
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
                            decoration: BoxDecoration(
                              color: orangeShade2,
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(243, 224, 207, 1)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(
                                children: [
                                  const CustomText(
                                    text: 'Transfer',
                                    textColor: black,
                                    fontSize: 13,
                                  ),
                                  CustomText(
                                    text:
                                        'NGN ${moneyFormat.format(double.parse(walletProvider.amountController.text.replaceAll(",", "")))}',
                                    textColor: black,
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
                                '${walletProvider.walletTagController.text} (${walletProvider.retrievedUserInfoModel?.data.name})',
                            textColor: black,
                          ),
                          TileWidget(
                            leading: 'Amount to send',
                            trailing:
                                '$nairaSign${moneyFormat.format(double.parse(walletProvider.amountController.text.replaceAll(",", "")))}',
                            textColor: black,
                          ),
                          const TileWidget(
                            leading: 'Transaction type',
                            trailing: 'Wallet Transfer',
                            textColor: Colors.black,
                          ),
                          const TileWidget(
                            leading: 'Transaction fee',
                            trailing: '$nairaSign 0.00',
                            textColor: black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              walletProvider.transferringFund
                                  ? const CupertinoActivityIndicator()
                                  : Expanded(
                                      child: MainButton('Send money',
                                          fontSize: 14, () async {
                                      final pin =
                                          await showVerifyTransactionPINModal(
                                              importedContext);
                                      if (pin != null) {
                                        bool fundTransferred =
                                            await walletProvider.transferFund(
                                                context: context, pin: pin);
                                        if (fundTransferred) {
                                          authProvider.getProfile(
                                              context: context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
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
