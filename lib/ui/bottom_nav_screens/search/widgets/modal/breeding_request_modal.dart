import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/search/widgets/dialogs/cross_deal_request_dialog.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/search/widgets/modal/select_cross_deal_modal.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:canine_castle_mobile/widgets/label_widget.dart';
import 'package:canine_castle_mobile/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../Widgets/components.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/image_constant.dart';
import '../../../../../utils/constants.dart';
import '../../../../../widgets/cached_network_image_widget.dart';

Future showBreedingRequestModal(BuildContext importedContext) {
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
                      height: 500,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: 'Breeding request',
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
                                    const SizedBox(height: 30),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(11.r),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x0A101928),
                                            blurRadius: 23.50,
                                            offset: Offset(0, 2),
                                            spreadRadius: -4,
                                          ),
                                          BoxShadow(
                                            color: Color(0x0A101928),
                                            blurRadius: 23.50,
                                            offset: Offset(0, 2),
                                            spreadRadius: -4,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                CachedNetworkImageWidget(
                                                  height: 68,
                                                  imageUrl: canineProvider
                                                          .selectedFemaleDog!
                                                          .relationships
                                                          .pictures
                                                          .isEmpty
                                                      ? ""
                                                      : canineProvider
                                                          .selectedFemaleDog!
                                                          .relationships
                                                          .pictures[0],
                                                  width: 78,
                                                  bottomLeftRadius: 5,
                                                  topLeftRadius: 5,
                                                  bottomRightRadius: 5,
                                                  topRightRadius: 5,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BodyTextPrimaryWithLineHeight(
                                                      text: canineProvider
                                                          .selectedFemaleDog!.name,
                                                      fontWeight: semiBoldFont,
                                                      textColor: black,
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    BodyTextPrimaryWithLineHeight(
                                                      text: canineProvider
                                                          .selectedFemaleDog!
                                                          .relationships
                                                          .breed,
                                                      fontWeight: semiBoldFont,
                                                      textColor: const Color.fromRGBO(
                                                          130, 130, 130, 1),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    BodyTextPrimaryWithLineHeight(
                                                      text: canineProvider
                                                          .selectedFemaleDog!.gender,
                                                      fontWeight: semiBoldFont,
                                                      textColor: const Color.fromRGBO(
                                                          130, 130, 130, 1),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const BodyTextPrimaryWithLineHeight(
                                      text: "Select cross deal",
                                      fontSize: 13,
                                      textColor: Color(0xFF0C0C0C),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomContainerButton(
                                      onTap: () {
                                        showSelectCrossDealModal(importedContext);
                                      },
                                      title: "",
                                      bgColor: const Color(0xFFF9F9F9),
                                      verticalPadding: 16,
                                      widget: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              BodyTextPrimaryWithLineHeight(
                                                text: canineProvider
                                                        .selectedCrossDeal?.type ??
                                                    "Select Cross Deal",
                                                textColor: const Color(0xFF0C0C0C),
                                                fontWeight: semiBoldFont,
                                              ),
                                              if (canineProvider.selectedCrossDeal !=
                                                  null)
                                                BodyTextPrimaryWithLineHeight(
                                                    text: canineProvider
                                                                .selectedCrossDeal !=
                                                            null
                                                        ? '$nairaSign${returnFormattedAmount(amount: canineProvider.selectedCrossDeal!.amount.toString())}'
                                                        : ''),
                                            ],
                                          )),
                                          SvgPicture.asset(dropdownIconSvg)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    if (!canineProvider.showAddOffer)
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 14.h),
                                        child: InkWell(
                                          onTap: () {
                                            canineProvider.updateShowAddOffer(true);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(addOfferIcon),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const BodyTextPrimaryWithLineHeight(
                                                text: "Add your offer",
                                                textColor:
                                                    Color.fromRGBO(10, 10, 11, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (canineProvider.showAddOffer)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const LabelWidget(
                                              label: "Enter your offer"),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomField(
                                                  "50,00",
                                                  canineProvider.yourOfferController,
                                                  isCapitalizeSentence: false,
                                                  type: const TextInputType
                                                      .numberWithOptions(
                                                      signed: true),
                                                  formatters: numbersOnlyFormat,
                                                  onChange: (value) {
                                                    if (value != null) {
                                                      if (value.isNotEmpty) {
                                                        var text = NumberFormat
                                                                .decimalPattern('en')
                                                            .format(int.parse(
                                                                value.replaceAll(
                                                                    ',', '')));
                                                        canineProvider
                                                            .yourOfferController
                                                            .value = TextEditingValue(
                                                          text: text,
                                                          selection:
                                                              TextSelection.collapsed(
                                                            offset: text.length,
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                                  prefixIcon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12, top: 13),
                                                    child: Text(nairaSign),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    const LabelWidget(
                                        label: "Enter message (optional)"),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: CustomField(
                                          "Enter Message",
                                          canineProvider.messageController,
                                          maxLines: 5,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: MainButton(continueTo,
                                                fontSize: 14, () async{
                                              showCrossDealDialog(importedContext);
                                        })),
                                      ],
                                    ),
                                    SizedBox(
                                      height: topPadding.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              );
            })),
      );
    },
  );
}
