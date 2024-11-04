import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../Widgets/title_widget.dart';
import '../../../../providers/inbox_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/navigation_utils.dart';
import '../request_detail_screen.dart';

class RequestsTab extends StatelessWidget {
  const RequestsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<InboxProvider>(builder: (ctx, inboxProvider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: inboxProvider.gettingStudRequest
              ? const CupertinoActivityIndicator()
              : inboxProvider.studRequests.isEmpty
                  ? const BodyTextPrimaryWithLineHeight(
                      text: "No Requests Yet",
                      fontWeight: semiBoldFont,
                      fontSize: 16,
                    )
                  : ListView.builder(
                      itemCount: inboxProvider.studRequests.length,
                      itemBuilder: (context, index) {
                        final request = inboxProvider.studRequests[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: InkWell(
                            onTap: () {
                              inboxProvider.updateSelectedRequest(request);
                              navToWithScreenName(
                                  context: context,
                                  screen: const RequestDetailScreen());
                            },
                            child: Container(
                              height: 230.h,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  top: 6, left: 6, right: 6, bottom: 12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11.r)),
                                shadows: const [
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
                              child: Column(
                                children: [
                                  Container(
                                    height: 152.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.r),
                                      image: DecorationImage(
                                          image: NetworkImage(request
                                                  .relationship
                                                  .pets[1]
                                                  .relationships
                                                  .pictures
                                                  .isEmpty
                                              ? ""
                                              : request.relationship.pets[1]
                                                  .relationships.pictures[0]),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 32.h,
                                        width: 32.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(56.r),
                                            color: hintTextColor
                                            // image: DecorationImage(
                                            //     image: AssetImage(""),
                                            //     fit: BoxFit.cover)
                                            ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TitleWidget(
                                                title: request
                                                    .relationship
                                                    .pets[1]
                                                    .relationships
                                                    .owner
                                                    .name,
                                                textColor: blackTextColor,
                                                fontWeight: mediumFont,
                                                fontSize: 14,
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              CustomContainerButton(
                                                onTap: () {},
                                                title: request.status
                                                    .toString()
                                                    .capitalize(),
                                                textColor: request.status !=
                                                        "pending"
                                                    ? const Color(0xFF301F10)
                                                    : const Color(0xFFD89B65),
                                                borderRadius: 20,
                                                bgColor: request.status !=
                                                        "pending"
                                                    ? const Color(0xFFF1EDE9)
                                                    : const Color(0xFFFBF5F0),
                                                verticalPadding: 2,
                                                horizontalPadding: 6,
                                                fontSize: 10,
                                                fontWeight: mediumFont,
                                              )
                                            ],
                                          ),
                                          BodyTextPrimaryWithLineHeight(
                                            text: request.message,
                                            fontWeight: mediumFont,
                                            fontSize: 13,
                                            textColor: const Color(0xFF626262),
                                            maxLines: 1,
                                          )
                                        ],
                                      )),
                                      SvgPicture.asset(forwardIconSvg),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
        );
      }),
    );
  }
}
