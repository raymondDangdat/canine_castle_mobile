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
              Consumer<SearchProvider>(builder: (ctx, searchProvider, child) {
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
                              itemCount: searchProvider.selectedDog?.images
                                  .length, // Number of pages to be built dynamically
                              itemBuilder: (BuildContext context, int index) {
                                final image =
                                    searchProvider.selectedDog?.images[index];
                                return Container(
                                  height: 370.h,
                                  decoration: BoxDecoration(
                                      color: bg,
                                      image: DecorationImage(
                                          image: AssetImage(image!),
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
                                      "${currentIndex + 1}/${searchProvider.selectedDog?.images.length}",
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
                                  text: searchProvider.selectedDog?.name ??
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
                                  text: searchProvider.selectedDog?.location ??
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
                                  text: searchProvider.selectedDog?.breed ??
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
                                  text: searchProvider.selectedDog?.gender ??
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
                                BodyTextPrimaryWithLineHeight(
                                  text: searchProvider.selectedDog?.rating ==
                                          null
                                      ? "No Rating"
                                      : "${searchProvider.selectedDog?.rating} (${searchProvider.selectedDog?.noOfRating})",
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
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const HeaderText(
                          text: description,
                          textColor: blackTextColor,
                          isUpperCase: false,
                        ),
                        BodyTextPrimaryWithLineHeight(
                          text: searchProvider.selectedDog!.description,
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
                                    text: searchProvider
                                                .selectedDog?.puppyDeal ==
                                            null
                                        ? "No Deal"
                                        : "NGN ${searchProvider.selectedDog?.puppyDeal}",
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
                                    text: searchProvider
                                                .selectedDog?.puppyDeal ==
                                            null
                                        ? "No Deal"
                                        : "NGN ${searchProvider.selectedDog?.noPuppyDeal}",
                                    textColor: blackTextColor,
                                    fontWeight: semiBoldFont,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 44.h,
                              width: 44.h,
                              child: Image.asset(
                                  searchProvider.selectedDog?.dogOwner.avatar ??
                                      ""),
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
                                    text: searchProvider
                                            .selectedDog?.dogOwner.name ??
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
                        ListView.builder(
                            itemCount:
                                searchProvider.selectedDog?.reviews.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final review =
                                  searchProvider.selectedDog?.reviews[index];
                              return Row(
                                children: [
                                  Container(
                                    height: 44.h,
                                    width: 44.h,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                  ),
                                ],
                              );
                            })
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
