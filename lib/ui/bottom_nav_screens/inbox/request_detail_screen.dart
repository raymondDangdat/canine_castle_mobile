import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
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
      body: SafeArea(
          child: Consumer<InboxProvider>(builder: (ctx, inboxProvider, child) {
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
                        borderRadius: BorderRadius.circular(56.r),
                        image: DecorationImage(
                            image: AssetImage(inboxProvider
                                    .selectedRequest?.requestUser.profileImg ??
                                ""),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          title: inboxProvider
                                  .selectedRequest?.requestUser.userName ??
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
                  Icon(
                    Iconsax.message,
                    size: 20.h,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 262.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFBF5F0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 160.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.r),
                              image: DecorationImage(
                                  image: AssetImage(
                                      inboxProvider.selectedRequest!.dogImg))),
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
                              children: [
                                Row(
                                  children: [
                                    TitleWidget(
                                      title:
                                          "${inboxProvider.selectedRequest!.dealType} ($nairaSign${inboxProvider.selectedRequest!.price})",
                                      textColor: blackTextColor,
                                      fontWeight: mediumFont,
                                      fontSize: 14,
                                    ),
                                  ],
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: inboxProvider
                                      .selectedRequest!.requestMessage,
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
                  )
                ],
              ),
            )),
            if (!inboxProvider.selectedRequest!.status)
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
                            () {},
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
                          () {},
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
