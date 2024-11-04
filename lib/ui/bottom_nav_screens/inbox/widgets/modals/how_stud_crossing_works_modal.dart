import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/inbox/widgets/modals/pick_availability_modal.dart';
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
import '../../../../../widgets/long_divider.dart';

Future showHowStudCrossingWorksModal(
  BuildContext importedContext,
) {
  List<String> getDatesBetween(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    List<String> dates = [];

    for (DateTime date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      dates.add(date.toIso8601String().split('T')[0]);
    }

    debugPrint("Dates:: ${dates[0]}");

    return dates;
  }

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
                      SizedBox(height: 14.h),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BodyTextLightWithLineHeight(
                            text: "How  it works",
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
                        height: 32.h,
                      ),
                      Column(
                        children: [
                          const HowItWorksItem(
                            label: "Accepting a request",
                            mainText:
                                "Upon accepting a request, your location details and phone number will be shared with the sender of the request",
                            sn: "1",
                          ),
                          const HowItWorksItem(
                            label: "Getting a secured payment",
                            mainText:
                                "The payment for a cross-deal is securely held by Canine castle until the sender confirms deal completion . ",
                            sn: "2",
                          ),
                          const HowItWorksItem(
                            label: "Payment Release",
                            mainText:
                                "Payment is sent to your  wallet 24 hours after confirmation, provided no issues are reported.",
                            sn: "3",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const LongDivider(),
                          SizedBox(
                            height: 20.h,
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
                                            bool isAccepted =
                                                await inboxProvider
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
                                        next,
                                        () async {
                                          List<String> dateList =
                                              getDatesBetween(
                                                  inboxProvider.selectedRequest!
                                                      .expectedDateFrom,
                                                  inboxProvider.selectedRequest!
                                                      .expectedDateTo);
                                          Navigator.pop(context);
                                          inboxProvider
                                              .updateSelectedAvailableDate("");
                                          showHowStudCrossingAvailabilityModal(
                                              importedContext,
                                              availableDates: dateList);
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: bottomPadding.h,
                          )
                        ],
                      ),
                    ],
                  );
                }),
              )));
    },
  );
}

class HowItWorksItem extends StatelessWidget {
  final String label;
  final String mainText;
  final String sn;
  const HowItWorksItem(
      {super.key,
      required this.label,
      required this.mainText,
      required this.sn});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: secondaryColor),
              alignment: Alignment.center,
              child: BodyTextLightWithLineHeight(
                text: sn,
                textColor: mainColor,
                fontWeight: semiBoldFont,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyTextPrimaryWithLineHeight(
                  text: label,
                  fontWeight: mediumFont,
                  textColor: blackTextColor,
                ),
                BodyTextPrimaryWithLineHeight(
                  text: mainText,
                  fontSize: 13,
                  textColor: blackTextColor,
                  fontWeight: regularFont,
                ),
              ],
            )),
          ],
        ),
        SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
