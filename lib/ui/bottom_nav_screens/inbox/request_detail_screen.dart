import 'package:canine_castle_mobile/providers/auth_provider.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/inbox/widgets/modals/how_stud_crossing_works_modal.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/title_widget.dart';
import '../../../providers/inbox_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/long_divider.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer2<InboxProvider, AuthProvider>(
          builder: (ctx, inboxProvider, authProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            CustomAppbar(
              title: "",
              widget: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(backArrowSvg)),
                  SizedBox(
                    width: 12.w,
                  ),
                  Container(
                    height: 32.h,
                    width: 32.h,
                    decoration: BoxDecoration(
                      color: hintTextColor,
                      borderRadius: BorderRadius.circular(56.r),
                      // image: const DecorationImage(
                      //     image: AssetImage(""),
                      //     fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          title: inboxProvider.selectedRequest?.relationship
                                  .pets[1].relationships.owner.name ??
                              "No Name",
                          fontSize: 16,
                          fontWeight: semiBoldFont,
                          textColor: blackTextColor,
                        ),
                        const BodyTextPrimaryWithLineHeight(
                          text: "Online",
                          fontSize: 10,
                          textColor: Color(0xFF181B01),
                        )
                      ],
                    ),
                  ),
                  SvgPicture.asset(moreIconVertical),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Container(
                      // height: 262.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFBF5F0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.r)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.r),
                                image: DecorationImage(
                                    image: NetworkImage(inboxProvider
                                            .selectedRequest!
                                            .relationship
                                            .pets[1]
                                            .relationships
                                            .pictures
                                            .isEmpty
                                        ? ""
                                        : inboxProvider
                                            .selectedRequest!
                                            .relationship
                                            .pets[1]
                                            .relationships
                                            .pictures[0]),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      TitleWidget(
                                        title:
                                            "${inboxProvider.selectedRequest!.deal} ($nairaSign${returnFormattedAmount(amount: inboxProvider.selectedRequest!.offerAmount.toString())})",
                                        textColor: blackTextColor,
                                        fontWeight: mediumFont,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                  BodyTextPrimaryWithLineHeight(
                                    text:
                                        inboxProvider.selectedRequest!.message,
                                    fontWeight: mediumFont,
                                    fontSize: 13,
                                    textColor: const Color(0xFF626262),
                                  )
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BodyTextPrimaryWithLineHeight(
                            text: returnFormattedDateAndTime(inboxProvider
                                .selectedRequest!.createdAt
                                .toString()))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  if (returnIsMaleDogOwner(
                      inboxProvider.selectedRequest!.relationship.pets))
                    Padding(
                      padding:
                          EdgeInsets.only(left: 70, right: horizontalPadding.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomContainerButton(
                            onTap: () {},
                            title: "",
                            bgColor: mainColor,
                            horizontalPadding: 10,
                            verticalPadding: 10,
                            borderRadius: 16,
                            widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomContainerButton(
                                  onTap: () {},
                                  title: "",
                                  widget: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "${returnFemalePet(inboxProvider.selectedRequest!.relationship.pets)?.relationships.owner.name ?? 'NA'}",
                                            textColor: const Color(0xFF181B01),
                                            fontSize: 10,
                                          ),
                                          BodyTextPrimaryWithLineHeight(
                                            text:
                                                "${inboxProvider.selectedRequest?.deal} ($nairaSign${returnFormattedAmount(amount: inboxProvider.selectedRequest!.offerAmount.toString())})",
                                            fontSize: 10,
                                          )
                                        ],
                                      )),
                                      Container(
                                        height: 34,
                                        width: 61,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    returnFemalePet(inboxProvider
                                                                .selectedRequest!
                                                                .relationship
                                                                .pets)
                                                            ?.relationships
                                                            .pictures[0] ??
                                                        ""),
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                const BodyTextPrimaryWithLineHeight(
                                  text: "You accepted request",
                                  textColor: white,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16))),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BodyTextPrimaryWithLineHeight(
                                    text:
                                        "Your address details and phone has been shared with the sender of the request.   Get set, they will be here soon",
                                    textColor: white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            )),

            // if (inboxProvider.selectedRequest!.status
            //         .toString()
            //         .toLowerCase() ==
            //     "pending")
            // Show this for male dog owner
            if (returnIsMaleDogOwner(
                    inboxProvider.selectedRequest!.relationship.pets) &&
                inboxProvider.selectedRequest?.status == "pending")
              Column(
                children: [
                  const LongDivider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: MainButton(
                            decline,
                            () {
                              showHowStudCrossingWorksModal(context);
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
                          () {
                            showHowStudCrossingWorksModal(context);
                          },
                        )),
                      ],
                    ),
                  )
                ],
              ),
          ],
        );
      })),
    );
  }
}
