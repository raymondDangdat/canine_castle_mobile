import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../providers/canine_provider.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../resources/styles_manager.dart';
import '../../../../../widgets/custom_snack_back.dart';

Future<void> showCrossDealDialog(
  BuildContext importedContext, {
  bool barrierDismissible = false,
}) async {
  showDialog(
      barrierDismissible: barrierDismissible,
      context: importedContext,
      builder: (BuildContext context) => CrossDealRequestDialog(
            importedContext: importedContext,
          ));
}

class CrossDealRequestDialog extends StatefulWidget {
  final BuildContext importedContext;
  const CrossDealRequestDialog({super.key, required this.importedContext});

  @override
  State<CrossDealRequestDialog> createState() => _CrossDealRequestDialogState();
}

class _CrossDealRequestDialogState extends State<CrossDealRequestDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.transparent,
        child: CustomContainerButton(
          onTap: () {},
          title: "",
          borderRadius: 12,
          height: 270,
          verticalPadding: 10,
          horizontalPadding: 20,
          useHeight: true,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(dogRequestInformationIcon),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              const BodyTextPrimaryWithLineHeight(
                text: "Cross deal request",
                textColor: Color(0xFF181B01),
                fontSize: 16,
                fontWeight: semiBoldFont,
              ),
              SizedBox(
                height: 8.h,
              ),
              Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
                return RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "Note that upon sending request, a sum of  ",
                    style: getRichTextStyle(
                        fontSize: 12,
                        textColor: black,
                        fontWeight: regularFont),
                    children: <TextSpan>[
                      TextSpan(
                          style: getCustomTextStyle(
                              fontSize: 12,
                              textColor: black,
                              fontWeight: boldFont),
                          text:
                              " N${returnFormattedAmount(amount: canineProvider.selectedCrossDeal!.amount)}"),
                      TextSpan(
                          style: getCustomTextStyle(
                              fontSize: 12,
                              textColor: black,
                              fontWeight: regularFont),
                          text:
                              " will be deducted from your wallet until the deal has been confirmed"),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 20.h,
              ),
              Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (canineProvider.resMessage != '') {
                    customSnackBar(context, canineProvider.resMessage,
                        isError: canineProvider.isErrorMessage);

                    ///Clear the response message to avoid duplicate
                    canineProvider.clear();
                  }
                });
                return Row(
                  children: [
                    Expanded(
                        child: MainButton(
                      "Cancel",
                      () {
                        Navigator.pop(context);
                      },
                      color: const Color(0xFFFBF5F0),
                      textColor: mainColor,
                    )),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: MainButton("Send", () async {
                      final sent = await canineProvider.sendStudRequest(
                          context: widget.importedContext);

                      debugPrint("Request Sent::: $sent");
                      if (sent) {
                        Navigator.pop(widget.importedContext);
                        Navigator.pop(context);
                      }
                    })),
                  ],
                );
              })
            ],
          ),
        ));
  }
}
