import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../Widgets/components.dart';
import '../../../../Widgets/custom_text.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import 'canine_of_the_day_item_widget.dart';

class CanineOfTheDayCard extends StatelessWidget {
  const CanineOfTheDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.w,
      ),
      child: Consumer2<AuthProvider, DashboardProvider>(
          builder: (ctx, authProvider, dashboardProvider, child) {
        return CustomContainerButton(
          onTap: () {},
          title: "",
          bgColor: const Color(0xFF0C0C0C),
          borderRadius: 12,
          verticalPadding: 20,
          height: 16,
          widget: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        color: const Color(0xFF0C0C0C),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(dashboardProvider
                                .dashboardInfoData
                                ?.canineOfTheDay
                                .relationships
                                .pictures[0]),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BodyTextPrimaryWithLineHeight(
                    text: dashboardProvider
                            .dashboardInfoData?.canineOfTheDay.name ??
                        "NA",
                    textColor: white,
                    fontWeight: boldFont,
                  )
                ],
              ),
              const SizedBox(
                width: 36,
              ),
              Expanded(
                child: Column(
                  children: [
                    CanineOfTheDayItemWidget(
                      title: dashboardProvider.dashboardInfoData?.canineOfTheDay
                              .relationships.breed ??
                          "NA",
                      iconName: canineOfTheDayBreedIcon,
                      textColor: const Color(0xFF0A8CE9),
                      bgColor: const Color(0x190B8CEA),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CanineOfTheDayItemWidget(
                      title: dashboardProvider.dashboardInfoData?.canineOfTheDay
                              .relationships.state ??
                          "NA",
                      iconName: canineOfTheDayLocationIcon,
                      textColor: const Color(0xFF0BE347),
                      bgColor: const Color(0x190BE448),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: [
                    CanineOfTheDayItemWidget(
                      title: dashboardProvider
                              .dashboardInfoData?.canineOfTheDay.gender ??
                          "NA",
                      iconName: canineOfTheDayGenderIcon,
                      textColor: const Color(0xFF12F3F3),
                      bgColor: const Color(0x1912F4F4),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CanineOfTheDayItemWidget(
                      title:
                          "${dashboardProvider.dashboardInfoData?.canineOfTheDay.relationships.reviews.totalReviewsCount} rating",
                      iconName: canineOfTheDayRatingStarIcon,
                      textColor: const Color.fromRGBO(255, 215, 0, 1),
                      bgColor: const Color(0x19FFD700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
