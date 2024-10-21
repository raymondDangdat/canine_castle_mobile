import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';

Future showSelectCrossDealModal(BuildContext importedContext) {
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
                Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.4,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.60),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: 'Select deal',
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
                              const SizedBox(height: 30),
                              ListView.builder(
                                  itemCount:
                                      canineProvider.crossDealOptions.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final deal =
                                        canineProvider.crossDealOptions[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: CustomContainerButton(
                                        onTap: () {
                                          canineProvider
                                              .updateSelectedCrossDeal(deal);
                                        },
                                        title: "",
                                        borderRadius: 11,
                                        bgColor:
                                            canineProvider.selectedCrossDeal ==
                                                    deal
                                                ? const Color(0xFFFBF5F0)
                                                : white,
                                        borderColor:
                                            canineProvider.selectedCrossDeal ==
                                                    deal
                                                ? mainColor
                                                : const Color(0xFFE6E6E6),
                                        widget: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BodyTextPrimaryWithLineHeight(
                                                    text: deal.type,
                                                    textColor:
                                                        const Color(0xFF0C0C0C),
                                                    fontWeight: semiBoldFont,
                                                  ),
                                                  BodyTextPrimaryWithLineHeight(
                                                    text:
                                                        "$nairaSign${returnFormattedAmount(amount: deal.amount)}",
                                                    textColor:
                                                        const Color(0xFF0C0C0C),
                                                    fontSize: 13,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SvgPicture.asset(canineProvider
                                                        .selectedCrossDeal ==
                                                    deal
                                                ? checkedIconSvg
                                                : uncheckedIconSvg)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: MainButton(continueTo,
                                          fontSize: 14, () {
                                    Navigator.pop(context);
                                  })),
                                ],
                              ),
                              SizedBox(
                                height: topPadding.h,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            })),
      );
    },
  );
}
