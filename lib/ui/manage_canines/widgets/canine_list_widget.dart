import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/manage_canines/canine_details_screen.dart';
import 'package:canine_castle_mobile/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../providers/canine_provider.dart';

class CaninesListWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CaninesListWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
      return Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: canineProvider.myCanines.length,
                  itemBuilder: (context, index) {
                    final canine = canineProvider.myCanines[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10,
                          left: horizontalPadding.w,
                          right: horizontalPadding.w),
                      child: InkWell(
                        onTap: () {
                          canineProvider.getSingleCanine(
                              context: context, canineSlug: canine.slug ?? "");
                          navToWithScreenName(
                              context: context,
                              screen: const CanineDetailScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CachedNetworkImageWidget(
                                      height: 68,
                                      imageUrl: canine
                                              .relationships.pictures.isEmpty
                                          ? ""
                                          : canine.relationships.pictures[0],
                                      width: 78,
                                      bottomLeftRadius: 5,
                                      topLeftRadius: 5,
                                      bottomRightRadius: 5,
                                      topRightRadius: 5,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.name,
                                          fontWeight: semiBoldFont,
                                          textColor: black,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.gender,
                                          fontWeight: semiBoldFont,
                                          textColor: const Color.fromRGBO(
                                              130, 130, 130, 1),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.relationships.breed,
                                          fontWeight: semiBoldFont,
                                          textColor: const Color.fromRGBO(
                                              130, 130, 130, 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      canine.isPublic == "1" || canine.isPublic
                                          ? eyesIcon
                                          : lockFromPublicIcon),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(forwardIcon)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      );
    });
  }
}

class FemaleCaninesListWidget extends StatelessWidget {
  const FemaleCaninesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
      return Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: canineProvider.myCanines.length,
                  itemBuilder: (context, index) {
                    final canine = canineProvider.myCanines[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 10,
                          left: horizontalPadding.w,
                          right: horizontalPadding.w),
                      child: InkWell(
                        onTap: () {
                          canineProvider.updateSelectedFemaleDog(canine);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: canineProvider.selectedFemaleDog == canine
                                ? Color(0xFFFBF5F0)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(11.r),
                            border: Border.all(
                                color:
                                    canineProvider.selectedFemaleDog == canine
                                        ? mainColor
                                        : Colors.transparent),
                            boxShadow: const [
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CachedNetworkImageWidget(
                                      height: 68,
                                      imageUrl: canine
                                              .relationships.pictures.isEmpty
                                          ? ""
                                          : canine.relationships.pictures[0],
                                      width: 78,
                                      bottomLeftRadius: 5,
                                      topLeftRadius: 5,
                                      bottomRightRadius: 5,
                                      topRightRadius: 5,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.name,
                                          fontWeight: semiBoldFont,
                                          textColor: black,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.gender,
                                          fontWeight: semiBoldFont,
                                          textColor: const Color.fromRGBO(
                                              130, 130, 130, 1),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canine.relationships.breed,
                                          fontWeight: semiBoldFont,
                                          textColor: const Color.fromRGBO(
                                              130, 130, 130, 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              if (canineProvider.selectedFemaleDog == canine)
                                SvgPicture.asset(checkedIconSvg),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      );
    });
  }
}
