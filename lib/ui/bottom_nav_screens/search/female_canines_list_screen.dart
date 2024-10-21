import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/search/widgets/modal/breeding_request_modal.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/canine_empty_state.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/canine_list_widget.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../resources/constants/string_constants.dart';

class FemaleCanineScreen extends StatefulWidget {
  const FemaleCanineScreen({super.key});

  @override
  State<FemaleCanineScreen> createState() => _FemaleCanineScreenState();
}

class _FemaleCanineScreenState extends State<FemaleCanineScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final canineProvider =
          Provider.of<CanineProvider>(context, listen: false);
      canineProvider.getCanines(context: context, filterFemaleCanines: true);
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
            const CustomAppbar(title: "Select dog"),
            canineProvider.gettingCanines
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : canineProvider.myCanines.isEmpty
                    ? const CaninesEmptyState()
                    : const Expanded(child: FemaleCaninesListWidget()),
            if (canineProvider.myCanines.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                child: MainButton(
                  next,
                  () {
                    if (canineProvider.selectedFemaleDog != null) {
                      canineProvider.updateShowAddOffer(false);
                      showBreedingRequestModal(context);
                    }
                  },
                ),
              )
          ],
        );
      })),
    );
  }
}
