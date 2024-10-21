import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/inbox/widgets/requests_tab.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../providers/inbox_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/constant_widgets.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final inboxProvider =
      Provider.of<InboxProvider>(context, listen: false);
      inboxProvider.getStudRequests(context: context);
    });

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Consumer<InboxProvider>(builder: (ctx, inboxProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            const CustomAppbar(title: "Requests",
              showArrowBack: false,
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding.w
              ),
              child: Row(
                children: [
                  CustomContainerButton(
                    onTap: () {
                      inboxProvider.updateIsCrossDealsTab(newValue: crossDealTab);
                    },
                    title: crossDealTab,
                    horizontalPadding: 12,
                    borderRadius: 100,
                    fontSize: 13,
                    textColor: inboxProvider.inboxTab == crossDealTab
                        ? mainColor
                        : blackTextColor,
                    fontWeight: semiBoldFont,
                    bgColor: inboxProvider.inboxTab == crossDealTab
                        ? const Color(0xFFFBF5F0)
                        : white,
                    verticalPadding: 8,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  CustomContainerButton(
                    onTap: () {
                      inboxProvider.updateIsCrossDealsTab(newValue: medicalTab);
                    },
                    title: medicalTab,
                    horizontalPadding: 12,
                    borderRadius: 100,
                    fontSize: 13,
                    textColor: inboxProvider.inboxTab == medicalTab
                        ? mainColor
                        : blackTextColor,
                    fontWeight: semiBoldFont,
                    bgColor: inboxProvider.inboxTab == medicalTab
                        ? const Color(0xFFFBF5F0)
                        : white,
                    verticalPadding: 8,
                  ),
                ],
              ),
            ),
             SizedBox(height: 28.h,),
             if(inboxProvider.inboxTab == crossDealTab)
             const RequestsTab(),
          ],
        );
      })),
    );
  }
}
