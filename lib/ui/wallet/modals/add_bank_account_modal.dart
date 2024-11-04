import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/wallet_provider.dart';
import 'package:canine_castle_mobile/ui/wallet/modals/show_bank_list_modal.dart';
import 'package:canine_castle_mobile/widgets/custom_snack_back.dart';
import 'package:canine_castle_mobile/widgets/label_widget.dart';
import 'package:canine_castle_mobile/widgets/textfields.dart';
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
import '../../../../../utils/constants.dart';

Future addBankAccountModal(BuildContext importedContext) {
  final accountNumberInput = TextEditingController();

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
                                  text: 'Add bank account',
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
                                    const BodyTextPrimaryWithLineHeight(
                                      text: "Select bank",
                                      fontSize: 13,
                                      textColor: Color(0xFF0C0C0C),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomContainerButton(
                                      onTap: () {
                                        if (walletProvider
                                            .allBanksToDisplay.isEmpty) {
                                          walletProvider.getBanks(
                                              context: importedContext);
                                        }
                                        walletProvider.resetBankList();
                                        walletProvider.resetRetrievedBankInfo();
                                        showBankListModal(importedContext);
                                      },
                                      title: "",
                                      borderColor: hintTextColor,
                                      verticalPadding: 16,
                                      widget: Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  BodyTextPrimaryWithLineHeight(
                                            text: walletProvider
                                                    .selectedBank?.name ??
                                                "Select Bank",
                                            textColor: blackTextColor,
                                          )),
                                          SvgPicture.asset(dropdownIconSvg)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const LabelWidget(
                                            label: "Enter account number"),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomField(
                                                "3055962326",
                                                accountNumberInput,
                                                isCapitalizeSentence: false,
                                                enabled: walletProvider
                                                        .selectedBank !=
                                                    null,
                                                length: 10,
                                                type: const TextInputType
                                                    .numberWithOptions(
                                                    signed: true),
                                                formatters: numbersOnlyFormat,
                                                onChange: (value) {
                                                  if (value != null) {
                                                    if (value.length == 10) {
                                                      walletProvider
                                                          .getAccountName(
                                                              context: context,
                                                              accountNumber:
                                                                  value);
                                                    } else {
                                                      walletProvider
                                                          .resetRetrievedBankInfo();
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),

                                    walletProvider.gettingAccountName
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 27),
                                            child: const Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const LabelWidget(
                                                  label: "Account name"),
                                              CustomContainerButton(
                                                onTap: () {},
                                                title: "",
                                                bgColor: const Color.fromRGBO(
                                                    243, 243, 243, 1),
                                                widget: Row(
                                                  children: [
                                                    BodyTextPrimaryWithLineHeight(
                                                      text: walletProvider
                                                              .accountNameRetrieved
                                                              ?.data ??
                                                          "....",
                                                      textColor:
                                                          const Color.fromRGBO(
                                                              13, 13, 13, 1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                    SizedBox(
                                      height: 24.h,
                                    ),

                                    // if(!walletProvider.gettingAccountName)
                                    walletProvider.addingBankAccount
                                        ? const Center(
                                            child: CupertinoActivityIndicator(),
                                          )
                                        : MainButton("Save account", () async {
                                            if (accountNumberInput
                                                    .text.length ==
                                                10) {
                                              if (walletProvider
                                                      .accountNameRetrieved !=
                                                  null) {
                                                bool accountAdded =
                                                    await walletProvider
                                                        .addBankAccount(
                                                            context: context,
                                                            accountNumber:
                                                                accountNumberInput
                                                                    .text);
                                                if (accountAdded) {
                                                  walletProvider
                                                      .getBankAccounts(
                                                          context: context);
                                                  Navigator.pop(context);
                                                }
                                              } else {
                                                customSnackBar(context,
                                                    "Unable to retrieve account details");
                                              }
                                            } else {
                                              customSnackBar(context,
                                                  "Enter a valid account number");
                                            }
                                          }),

                                    SizedBox(
                                      height: topPadding.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
