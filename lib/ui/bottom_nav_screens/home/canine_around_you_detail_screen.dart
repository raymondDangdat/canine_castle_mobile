import 'package:canine_castle_mobile/providers/dashboard_provider.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/home/widgets/canine_around_you_widget.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/custom_text.dart';
import '../../../providers/auth_provider.dart';
import '../../../resources/constants/color_constants.dart';
import '../../../resources/constants/font_constants.dart';
import '../../../resources/constants/image_constant.dart';

class CanineAroundYouDetailScreen extends StatefulWidget {
  const CanineAroundYouDetailScreen({super.key});

  @override
  State<CanineAroundYouDetailScreen> createState() =>
      _CanineAroundYouDetailScreenState();
}

class _CanineAroundYouDetailScreenState
    extends State<CanineAroundYouDetailScreen> with TickerProviderStateMixin {
  PageController pageViewController = PageController();

  int selectedIndex = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Consumer2<AuthProvider, DashboardProvider>(
              builder: (ctx, authProvider, dashboardProvider, child) {
            return Column(
              children: [
                const TopPadding(),
                const CustomAppbar(title: "Around you"),
                Expanded(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: pageViewController,
                            itemCount: dashboardProvider.selectedCanineOfTheDay
                                ?.relationships.pictures.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                dashboardProvider.selectedCanineOfTheDay
                                    ?.relationships.pictures[index],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                      child: CupertinoActivityIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                      child: Text("Failed to load image"));
                                },
                              );
                            },
                            onPageChanged: (index) {
                              selectedIndex = index;
                              setState(() {

                              });
                              debugPrint("Current Index $index");
                            },
                          ),
                          Positioned(
                            bottom: 20,
                            left: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: dashboardProvider
                                          .selectedCanineOfTheDay?.name ??
                                      "NA",
                                  textColor: white,
                                  fontWeight: boldFont,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                BodyTextPrimaryWithLineHeight(
                                  text: dashboardProvider.selectedCanineOfTheDay
                                          ?.relationships.breed ??
                                      "NA",
                                  textColor: white,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 9,
                            child: Column(
                              children: [
                                CanineAroundYouItem(
                                    value:
                                        "${dashboardProvider.selectedCanineOfTheDay?.relationships.reviews.totalReviewsCount ?? '0'}",
                                    icon: canineAroundYouStarIcon),
                                const SizedBox(
                                  height: 10,
                                ),
                                CanineAroundYouItem(
                                    value:
                                        "${dashboardProvider.selectedCanineOfTheDay?.gender ?? 'NA'}",
                                    icon: forYouMaleIcon),
                                const SizedBox(
                                  height: 10,
                                ),
                                CanineAroundYouItem(
                                    value:
                                        "${dashboardProvider.selectedCanineOfTheDay?.relationships.state ?? '0'}",
                                    icon: forYouLocationIcon),
                              ],
                            ),
                          ),

                          Positioned(
                            bottom: 20, // Adjust this value to control the vertical position
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 6,
                                child: ListView.builder(
                                  itemCount: dashboardProvider.selectedCanineOfTheDay?.relationships.pictures.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: index == selectedIndex ? Colors.white : const Color(0x7FD9D9D9),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            );
          })),
    );
  }
}
