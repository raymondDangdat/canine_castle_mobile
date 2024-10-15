import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/manage_canines/add_canine_screen.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/canine_empty_state.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/canine_list_widget.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../resources/constants/string_constants.dart';

class MyCanineScreen extends StatefulWidget {
  const MyCanineScreen({super.key});

  @override
  State<MyCanineScreen> createState() => _MyCanineScreenState();
}

class _MyCanineScreenState extends State<MyCanineScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final canineProvider =
          Provider.of<CanineProvider>(context, listen: false);
      canineProvider.getCanines(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(child:
          Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
        return Column(
          children: [
            const TopPadding(),
            const CustomAppbar(title: myCanines),
            canineProvider.gettingCanines
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : canineProvider.myCanines.isEmpty
                    ? const CaninesEmptyState()
                    : const Expanded(child: CaninesListWidget()),
            if (canineProvider.myCanines.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: MainButton(
                  "",
                  () {
                    canineProvider.getPetBreeds(context: context);
                    canineProvider.getStatesOrCities(context: context);
                    navToWithScreenName(
                        context: context, screen: const AddCanineScreen());
                  },
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(addIcon),
                      SizedBox(
                        width: 5.w,
                      ),
                      const BodyTextPrimaryWithLineHeight(
                        text: addCanine,
                        textColor: white,
                        fontWeight: semiBoldFont,
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      })),
    );
  }
}
