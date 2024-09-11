import 'package:canine_castle_mobile/ui/bottom_nav_screens/inbox/widgets/requests_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/title_widget.dart';
import '../../../providers/inbox_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Consumer<InboxProvider>(builder: (ctx, inboxProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                children: [
                  const TitleWidget(
                    title: inbox,
                    fontSize: 23,
                    fontWeight: semiBoldFont,
                    textColor: blackTextColor,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      CustomContainerButton(
                        onTap: () {
                          inboxProvider.updateIsDogTab(newValue: true);
                        },
                        title: "Messages(10)",
                        horizontalPadding: 12,
                        borderRadius: 100,
                        fontSize: 13,
                        textColor: inboxProvider.isMessagesTab
                            ? mainColor
                            : blackTextColor,
                        fontWeight: semiBoldFont,
                        bgColor: inboxProvider.isMessagesTab
                            ? const Color(0xFFFBF5F0)
                            : white,
                        verticalPadding: 8,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      CustomContainerButton(
                        onTap: () {
                          inboxProvider.updateIsDogTab(newValue: false);
                        },
                        title: "Request",
                        horizontalPadding: 12,
                        borderRadius: 100,
                        fontSize: 13,
                        textColor: !inboxProvider.isMessagesTab
                            ? mainColor
                            : blackTextColor,
                        fontWeight: semiBoldFont,
                        bgColor: !inboxProvider.isMessagesTab
                            ? const Color(0xFFFBF5F0)
                            : white,
                        verticalPadding: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 34.h,
            ),
            if (!inboxProvider.isMessagesTab) const RequestsTab(),
          ],
        );
      })),
    );
  }
}
