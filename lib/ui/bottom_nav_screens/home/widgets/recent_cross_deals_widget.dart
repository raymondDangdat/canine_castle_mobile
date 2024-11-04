import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';

class RecentCrossDealsWidget extends StatelessWidget {
  const RecentCrossDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
      return SizedBox(
        height: 130,
        child: ListView.builder(
            itemCount:
                dashboardProvider.dashboardInfoData?.recentCrossDeals.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final deal =
                  dashboardProvider.dashboardInfoData?.recentCrossDeals[index];
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? horizontalPadding.w : 0, right: 20),
                child: Container(
                  height: 130,
                  width: 64,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 1),
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    deal!.relationships.pictures.isEmpty
                                        ? ""
                                        : deal.relationships.pictures[0]),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BodyTextPrimaryWithLineHeight(
                        text: "${deal.name ?? 'NA'}",
                        maxLines: 1,
                        textColor: black,
                        fontWeight: semiBoldFont,
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}
