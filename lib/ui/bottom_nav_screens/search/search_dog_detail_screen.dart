import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../providers/search_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../widgets/view_all_widget.dart';

class SearchedDogDetailScreen extends StatefulWidget {
  const SearchedDogDetailScreen({Key? key}) : super(key: key);

  @override
  State<SearchedDogDetailScreen> createState() =>
      _SearchedDogDetailScreenState();
}

class _SearchedDogDetailScreenState extends State<SearchedDogDetailScreen> {
  final searchController = TextEditingController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          top: false,
          child:
              Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 370.h,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          child: SizedBox(
                            height: 370.h,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                              onPageChanged: (index) {
                                currentIndex = index;
                                setState(() {});
                              },
                              itemCount: canineProvider
                                  .selectedCanine
                                  ?.relationships
                                  .pictures
                                  .length, // Number of pages to be built dynamically
                              itemBuilder: (BuildContext context, int index) {
                                final image = canineProvider.selectedCanine
                                    ?.relationships.pictures[index];
                                return Container(
                                  height: 370.h,
                                  decoration: BoxDecoration(
                                      color: bg,
                                      image: DecorationImage(
                                          image: NetworkImage(image!),
                                          fit: BoxFit.cover)),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: horizontalPadding.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.49),
                                    borderRadius: BorderRadius.circular(18.r)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: BodyTextPrimaryWithLineHeight(
                                  text:
                                      "${currentIndex + 1}/${canineProvider.selectedCanine?.relationships.pictures.length}",
                                  textColor:
                                      const Color.fromRGBO(13, 13, 13, 1),
                                  fontWeight: mediumFont,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 300.h,
                          right: horizontalPadding.w,
                          left: horizontalPadding.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 34.h,
                                  width: 34.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.49)),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 12.w),
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 34.h,
                                width: 34.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(255, 255, 255, 0.49)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  child: const Icon(
                                    Icons.ios_share,
                                    color: white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                HeaderText(
                                  text: canineProvider.selectedCanine?.name ??
                                      "No Name",
                                  isUpperCase: false,
                                  fontWeight: semiBoldFont,
                                  fontSize: 23,
                                  textColor:
                                      const Color.fromRGBO(43, 43, 43, 1),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                SvgPicture.asset(verifiedBadge)
                              ],
                            ),
                            SizedBox(
                              height: 32.h,
                              width: 32.h,
                              child: Image.asset(favouriteImg),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(dogLocationIconSvg),
                                SizedBox(
                                  width: 4.w,
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: canineProvider.selectedCanine
                                          ?.relationships.state ??
                                      "No Location",
                                  fontSize: 13,
                                  textColor:
                                      const Color.fromRGBO(98, 98, 98, 1),
                                  fontWeight: mediumFont,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(dogBreedImgSvg),
                                SizedBox(
                                  width: 4.w,
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: canineProvider.selectedCanine
                                          ?.relationships.breed ??
                                      "No Bredd",
                                  fontSize: 13,
                                  textColor:
                                      const Color.fromRGBO(98, 98, 98, 1),
                                  fontWeight: mediumFont,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(dogGenderImgSVG),
                                SizedBox(
                                  width: 4.w,
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: canineProvider.selectedCanine?.gender ??
                                      "No Gender",
                                  fontSize: 13,
                                  textColor:
                                      const Color.fromRGBO(98, 98, 98, 1),
                                  fontWeight: mediumFont,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(starRatingImgSvg),
                                SizedBox(
                                  width: 4.w,
                                ),
                                const BodyTextPrimaryWithLineHeight(
                                  text: "4 (45)",
                                  fontSize: 13,
                                  textColor: Color.fromRGBO(98, 98, 98, 1),
                                  fontWeight: mediumFont,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (canineProvider
                                .selectedCanine!.studParams?.contractBrief !=
                            null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeaderText(
                                text: description,
                                textColor: blackTextColor,
                                isUpperCase: false,
                              ),
                              BodyTextPrimaryWithLineHeight(
                                text: canineProvider.selectedCanine!.studParams
                                        ?.contractBrief ??
                                    "",
                                textColor: const Color.fromRGBO(76, 76, 76, 1),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              const HeaderText(
                                text: crossDeals,
                                textColor: blackTextColor,
                                isUpperCase: false,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              CustomContainerButton(
                                onTap: () {},
                                title: "",
                                verticalPadding: 15,
                                horizontalPadding: 10,
                                bgColor: const Color.fromRGBO(249, 249, 249, 1),
                                borderRadius: 12,
                                widget: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const BodyTextPrimaryWithLineHeight(
                                          text: puppyDeal,
                                          fontWeight: mediumFont,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canineProvider
                                                      .selectedCanine
                                                      ?.studParams
                                                      ?.puppyDealAmount ==
                                                  null
                                              ? "No Deal"
                                              : "NGN ${canineProvider.selectedCanine?.studParams?.puppyDealAmount}",
                                          textColor: blackTextColor,
                                          fontWeight: semiBoldFont,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const BodyTextPrimaryWithLineHeight(
                                          text: noPuppyDeal,
                                          fontWeight: mediumFont,
                                        ),
                                        BodyTextPrimaryWithLineHeight(
                                          text: canineProvider
                                                      .selectedCanine
                                                      ?.studParams
                                                      ?.noPuppyDealAmount ==
                                                  null
                                              ? "No Deal"
                                              : "NGN ${canineProvider.selectedCanine?.studParams?.noPuppyDealAmount}",
                                          textColor: blackTextColor,
                                          fontWeight: semiBoldFont,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 44.h,
                              width: 44.h,
                              child: Image.asset(""),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BodyTextPrimaryWithLineHeight(
                                    text: "Pet owner",
                                    textColor: Color.fromRGBO(130, 130, 130, 1),
                                    fontSize: 11,
                                    fontWeight: mediumFont,
                                  ),
                                  BodyTextPrimaryWithLineHeight(
                                    text: canineProvider.selectedCanine
                                            ?.relationships.owner.name ??
                                        "NAN",
                                    textColor:
                                        const Color.fromRGBO(13, 13, 13, 1),
                                    fontWeight: semiBoldFont,
                                  )
                                ],
                              ),
                            ),
                            SvgPicture.asset(sendMessageToOwnerIcon)
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ViewAllWidget(
                          title: customerReviews,
                          onTap: () {},
                          padding: 0,
                          titleTextColor: const Color.fromRGBO(13, 13, 13, 1),
                          titleFontWeight: semiBoldFont,
                          subTitleTextColor:
                              const Color.fromRGBO(216, 155, 101, 1),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // ListView.builder(
                        //     itemCount:
                        //         canineProvider.selectedCanine?.reviews.length,
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //       final review =
                        //           canineProvider.selectedDog?.reviews[index];
                        //       return Row(
                        //         children: [
                        //           Container(
                        //             height: 44.h,
                        //             width: 44.h,
                        //             decoration:
                        //                 BoxDecoration(shape: BoxShape.circle),
                        //           ),
                        //         ],
                        //       );
                        //     })
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
