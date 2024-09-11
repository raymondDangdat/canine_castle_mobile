import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../resources/constants/color_constants.dart';
import '../../../../../resources/constants/dimension_constants.dart';
import '../../../../../widgets/long_divider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../resources/constants/font_constants.dart';

Future showVetProfessionalHowItWorksModal(
  BuildContext importedContext,
) {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 20.h,
                    ),
                    const BodyTextLightWithLineHeight(
                      text: "How  it works",
                      textColor: blackTextColor,
                      fontSize: 23,
                      fontWeight: semiBoldFont,
                    ),
                    Column(
                      children: [
                        const HowItWorksItem(
                          label: "Send a Medical Request:",
                          mainText:
                              "Submit a request to update a canine's health report during their clinic visit.",
                          sn: "1",
                        ),
                        const HowItWorksItem(
                          label: "Pet - owner Approval",
                          mainText:
                              "The owner accepts the request, allowing you to enter the medical details.",
                          sn: "2",
                        ),
                        const HowItWorksItem(
                          label: "Record & Update",
                          mainText:
                              "Enter and save the canine's medical details in the app.",
                          sn: "3",
                        ),
                        const HowItWorksItem(
                          label: "Crossbreeding Participation",
                          mainText:
                              "Search breeds, send cross-deal requests, and participate in crossbreeding, just like pet owners.",
                          sn: "4",
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
                        MainButton(
                            "Start my 1 month free trial", () async {}),
                        SizedBox(
                          height: bottomPadding.h,
                        )
                      ],
                    ),
                  ],
                ),
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
                shape: BoxShape.circle,
                color: secondaryColor
              ),
              alignment: Alignment.center,
              child: BodyTextLightWithLineHeight(text: sn,
              textColor: mainColor,
              fontWeight: semiBoldFont,),
            ),
            SizedBox(width: 5.w,),
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
