import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/canine_around_you_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/canine_of_the_day_card.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/facourite_canine_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/my_canines_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/nearest_clinics_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/recent_cross_deals_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/section_header_widget.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dashboard_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer2<AuthProvider, DashboardProvider>(
          builder: (ctx, authProvider, dashboardProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropdownButton(
                      title: "",
                      onTap: () {},
                      bgColor: const Color(0xFFF9F9F9),
                      borderRadius: 32,
                      borderColor: const Color(0xFFF9F9F9),
                      customWidget: Row(
                        children: [
                          SvgPicture.asset(dashboardLocationIcon),
                          SizedBox(
                            width: 8.w,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const BodyTextPrimaryWithLineHeight(
                              text: "HBC Resort, Jos",
                              textColor: Color(0xFF0C0C0C),
                              fontSize: 13,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
                child: dashboardProvider.gettingDashboardInfo
                    ? const Center(child: CupertinoActivityIndicator())
                    : Container(
                        color: const Color.fromRGBO(250, 250, 250, 1),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24.h,
                              ),
                              SectionHeaderWidget(
                                onTap: () {},
                                title: "Canine of the day",
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const CanineOfTheDayCard(),
                              SizedBox(
                                height: 32.h,
                              ),
                              SectionHeaderWidget(
                                onTap: () {},
                                title: "Around you",
                                seeMoreText: seeAll,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const CanineAroundYouWidget(),
                              SizedBox(
                                height: 32.h,
                              ),
                              SectionHeaderWidget(
                                onTap: () {},
                                title: "Nearest clinics",
                                seeMoreText: seeAll,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const NearestClinicsWidget(),
                              SizedBox(
                                height: 32.h,
                              ),
                              SectionHeaderWidget(
                                  onTap: () {}, title: "Recent cross deals"),
                              SizedBox(
                                height: 16.h,
                              ),
                              const RecentCrossDealsWidget(),
                              SizedBox(
                                height: 32.h,
                              ),
                              SectionHeaderWidget(
                                onTap: () {},
                                title: "My canines",
                                seeMoreText: seeAll,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const MyCanineWidget(),
                              SizedBox(
                                height: 32.h,
                              ),
                              SectionHeaderWidget(
                                onTap: () {},
                                title: "My favorites",
                                seeMoreText: seeAll,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              const FavouriteCanineWidget(),
                            ],
                          ),
                        ),
                      ))
          ],
        );
      })),
    );
  }
}

class CanineInfoItem extends StatelessWidget {
  final String icon;
  final String value;
  const CanineInfoItem({super.key, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(icon),
        BodyTextPrimaryWithLineHeight(
          text: value,
          textColor: white,
          fontSize: 10,
        ),
      ],
    );
  }
}
