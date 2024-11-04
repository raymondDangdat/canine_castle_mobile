import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../providers/dashboard_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';

class MyCanineWidget extends StatelessWidget {
  const MyCanineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (ctx, dashboardProvider, child) {
      return SizedBox(
        height: 170,
        child: ListView.builder(
            itemCount: dashboardProvider.dashboardInfoData?.myCanines.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final canine =
                  dashboardProvider.dashboardInfoData?.myCanines[index];
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? horizontalPadding.w : 0, right: 12),
                child: Container(
                  height: 161,
                  width: 156,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImageWidget(
                        height: 100,
                        width: 144,
                        imageUrl: canine == null ||
                                canine.relationships.pictures.isEmpty
                            ? ""
                            : canine.relationships.pictures[0],
                        topRightRadius: 7, bottomRightRadius: 7,
                        bottomLeftRadius: 7, topLeftRadius: 7,
                        // clinic?.relationships.coverImage ?? ""
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BodyTextPrimaryWithLineHeight(
                        text: "${canine?.name ?? 'NA'}",
                        maxLines: 1,
                        textColor: black,
                        fontWeight: semiBoldFont,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              SvgPicture.asset(locationIcon),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                  child: BodyTextPrimaryWithLineHeight(
                                text: "${canine?.relationships.breed ?? "NA"}",
                                maxLines: 1,
                              )),
                            ],
                          )),
                          const SizedBox(
                            width: 2,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                canine?.gender.toString().toLowerCase() ==
                                        male.toLowerCase()
                                    ? maleIcon
                                    : femaleGenderIcon,
                                color: const Color.fromRGBO(163, 163, 163, 1),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}
