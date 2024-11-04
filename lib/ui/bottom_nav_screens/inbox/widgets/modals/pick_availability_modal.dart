import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../Widgets/components.dart';
import '../../../../../Widgets/custom_text.dart';
import '../../../../../providers/inbox_provider.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../resources/constants/font_constants.dart';
import '../../../../../resources/constants/string_constants.dart';
import '../../../../../widgets/custom_snack_back.dart';

Future showHowStudCrossingAvailabilityModal(BuildContext importedContext,
    {required List<String> availableDates}) {
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: Consumer<InboxProvider>(
                    builder: (ctx, inboxProvider, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (inboxProvider.resMessage != '') {
                      customSnackBar(context, inboxProvider.resMessage,
                          isError: inboxProvider.isErrorMessage);

                      ///Clear the response message to avoid duplicate
                      inboxProvider.clear();
                    }
                  });
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BodyTextLightWithLineHeight(
                            text: "Pick availability",
                            textColor: blackTextColor,
                            fontSize: 23,
                            fontWeight: semiBoldFont,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(closeIconSvg)),
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      const BodyTextPrimaryWithLineHeight(
                        text: "I will be available on",
                        textColor: Color.fromRGBO(13, 13, 13, 1),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      ListView.builder(
                          itemCount: availableDates.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final availableDate = availableDates[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: CustomContainerButton(
                                onTap: () {
                                  inboxProvider.updateSelectedAvailableDate(
                                      availableDate);
                                },
                                title: "",
                                bgColor: inboxProvider.selectedAvailableDate ==
                                        availableDate
                                    ? const Color(0xFFFBF5F0)
                                    : white,
                                borderColor:
                                    inboxProvider.selectedAvailableDate ==
                                            availableDate
                                        ? mainColor
                                        : const Color(0xFFE6E6E6),
                                borderRadius: 11,
                                widget: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyTextPrimaryWithLineHeight(
                                      text: returnFormattedDate(availableDate),
                                      textColor: const Color(0xFF0C0C0C),
                                    ),
                                    SvgPicture.asset(
                                        inboxProvider.selectedAvailableDate ==
                                                availableDate
                                            ? checkedIconSvg
                                            : uncheckedIconSvg)
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      inboxProvider.updatingStudRequest
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MainButton(
                                      decline,
                                      () async {
                                        bool isAccepted = await inboxProvider
                                            .updateStudRequest(
                                                context: context,
                                                status: "declined");
                                        if (isAccepted) {
                                          inboxProvider.getStudRequests(
                                              context: context);
                                          Navigator.pop(context);
                                          Navigator.pop(importedContext);
                                        }
                                      },
                                      color: const Color(0xFFF9F0E8),
                                      textColor: mainColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  Expanded(
                                      child: MainButton(
                                    accept,
                                    () async {
                                      if (inboxProvider.selectedAvailableDate !=
                                              null &&
                                          inboxProvider.selectedAvailableDate!
                                              .isNotEmpty) {
                                        bool isAccepted = await inboxProvider
                                            .updateStudRequest(
                                                context: context,
                                                status: "accepted");
                                        if (isAccepted) {
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        customSnackBar(context,
                                            "Chose a valid available date");
                                      }
                                    },
                                  )),
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  );
                }),
              )));
    },
  );
}
