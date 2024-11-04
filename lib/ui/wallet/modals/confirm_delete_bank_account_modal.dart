import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:canine_castle_mobile/widgets/label_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';

Future showConfirmDeleteBankAccountModal(BuildContext importedContext) {
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
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(modalRadius.r),
                  topRight: Radius.circular(modalRadius.r)),
            ),
            child:
                Consumer<WalletProvider>(builder: (ctx, walletProvider, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (walletProvider.resMessage != '') {
                  customSnackBar(context, walletProvider.resMessage,
                      isError: walletProvider.isError);

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
                    SizedBox(
                        height: 500,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'Delete bank account',
                                  textColor: black,
                                  fontSize: 16,
                                  fontWeight: titleFont,
                                ),
                                Container(),
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(cancel)),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    const LabelWidget(label: "Account name"),
                                    BodyTextPrimaryWithLineHeight(
                                      text: walletProvider.selectedBankAccount
                                              ?.accountName ??
                                          "NA",
                                      textColor: const Color(0xFF0A0A0B),
                                      fontWeight: semiBoldFont,
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    const LabelWidget(label: "Account Number"),
                                    BodyTextPrimaryWithLineHeight(
                                      text: walletProvider.selectedBankAccount
                                              ?.accountNumber ??
                                          "NA",
                                      textColor: const Color(0xFF0A0A0B),
                                      fontWeight: semiBoldFont,
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    const LabelWidget(label: "Bank name"),
                                    BodyTextPrimaryWithLineHeight(
                                      text: walletProvider
                                              .selectedBankAccount?.bankName ??
                                          "NA",
                                      textColor: const Color(0xFF0A0A0B),
                                      fontWeight: semiBoldFont,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            walletProvider.deletingBankAccount
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : MainButton(
                                    "Delete Bank Account",
                                    () async {
                                      bool deleted = await walletProvider
                                          .deleteBankAccount(context: context);
                                      if (deleted) {
                                        walletProvider.getBankAccounts(
                                            context: context);
                                        Navigator.pop(context);
                                      }
                                    },
                                    color: const Color(0xFFF4451A),
                                  ),
                            SizedBox(
                              height: bottomPadding.h,
                            )
                          ],
                        )),
                  ],
                ),
              );
            })),
      );
    },
  );
}
