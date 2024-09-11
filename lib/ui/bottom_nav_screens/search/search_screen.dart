import 'package:canine_castle_mobile/ui/bottom_nav_screens/search/search_dog_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/components.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/title_widget.dart';
import '../../../providers/search_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/dimension_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';
import '../../../resources/constants/string_constants.dart';
import '../../../resources/navigation_utils.dart';
import '../../../widgets/constant_widgets.dart';
import '../../../widgets/textfields.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(child:
          Consumer<SearchProvider>(builder: (ctx, searchProvider, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopPadding(),
                  const TitleWidget(
                    title: "Search",
                    fontSize: 18,
                    fontWeight: mediumFont,
                    textColor: blackTextColor,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomContainerButton(
                    onTap: () {},
                    title: "",
                    borderRadius: 18,
                    horizontalPadding: 16,
                    verticalPadding: 8,
                    bgColor: const Color(0xFFF9F9F9),
                    widget: Row(
                      children: [
                        SvgPicture.asset(searchIconSvg),
                        Expanded(
                            child: CustomField(
                          "Search ",
                          searchController,
                          hasBorder: false,
                          fillColor: const Color(0xFFF9F9F9),
                          bgColor: const Color(0xFFF9F9F9),
                        )),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(filterIcon),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      CustomContainerButton(
                        onTap: () {
                          searchProvider.updateIsDogTab(newValue: true);
                        },
                        title: dogs,
                        horizontalPadding: 12,
                        borderRadius: 100,
                        fontSize: 13,
                        textColor: searchProvider.isDogTab
                            ? mainColor
                            : blackTextColor,
                        fontWeight: semiBoldFont,
                        bgColor: searchProvider.isDogTab
                            ? const Color(0xFFFBF5F0)
                            : white,
                        verticalPadding: 8,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      CustomContainerButton(
                        onTap: () {
                          searchProvider.updateIsDogTab(newValue: false);
                        },
                        title: vets,
                        horizontalPadding: 12,
                        borderRadius: 100,
                        fontSize: 13,
                        textColor: !searchProvider.isDogTab
                            ? mainColor
                            : blackTextColor,
                        fontWeight: semiBoldFont,
                        bgColor: !searchProvider.isDogTab
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
              height: 24.h,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 169.w,
                      childAspectRatio: MediaQuery.of(context).size.width > 480
                          ? 5 / 6
                          : 3 / 4,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h),
                  itemBuilder: (context, index) {
                    // final task = engagementTaskList[index];
                    final dog = searchProvider.dogs[index];
                    return GestureDetector(
                        onTap: () async {
                          searchProvider.updateSelectedDog(dog);
                          navToWithScreenName(
                              context: context,
                              screen: const SearchedDogDetailScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.r),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100.h,
                                width: 144.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.r),
                                    image: DecorationImage(
                                        image: AssetImage(dog.images[0]),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: BodyTextLightWithLineHeight(
                                    text: dog.name,
                                    fontWeight: semiBoldFont,
                                    textColor: black,
                                  )),
                                  InkWell(
                                    onTap: () {
                                      searchProvider.updateIsFavourite(
                                          dog: dog, index: index);
                                    },
                                    child: SvgPicture.asset(dog.isFavourite
                                        ? isFavouriteDogImg
                                        : notFavouriteDogImg),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              BodyTextLightWithLineHeight(
                                text: dog.breed,
                                textColor: const Color(0xFF626262),
                                fontSize: 12,
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(locationIcon),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      BodyTextLightWithLineHeight(
                                        text: dog.location,
                                        fontSize: 12,
                                        textColor: const Color(0xFF828282),
                                      )
                                    ],
                                  ),
                                  CustomContainerButton(
                                    onTap: () {},
                                    title: dog.age,
                                    bgColor: const Color(0xFFFBF5F0),
                                    horizontalPadding: 4,
                                    verticalPadding: 4,
                                    borderRadius: 56,
                                    textColor: const Color(0xFFD89B65),
                                    fontWeight: mediumFont,
                                  )
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                  itemCount: searchProvider.dogs.length),
            )),
            SizedBox(
              height: bottomPadding.h,
            )
          ],
        );
      })),
    );
  }
}
