import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../Widgets/components.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/dimension_constants.dart';
import '../../../../resources/constants/image_constant.dart';

Future showPetBreedSelectionModal(BuildContext importedContext) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    context: importedContext,
    backgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(modalRadius.r),
          topRight: Radius.circular(modalRadius.r)),
    ),
    builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(modalRadius.r),
                topRight: Radius.circular(modalRadius.r)),
          ),
          child:
              Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 14.h),
                SizedBox(
                  height: 19.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BodyTextPrimaryWithLineHeight(
                              text: selectAnOption),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(closeIconSvg))
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                canineProvider.gettingPetBreeds
                    ? Padding(
                        padding: EdgeInsets.only(bottom: bottomPadding.h),
                        child: const CupertinoActivityIndicator(),
                      )
                    : canineProvider.petBreeds.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(bottom: bottomPadding.h),
                            child: const BodyTextPrimaryWithLineHeight(
                                text: "No Pet Breeds Yet"),
                          )
                        : Container(
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.4,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.75),
                            child: ListView.builder(
                                itemCount: canineProvider.petBreeds.length,
                                itemBuilder: (context, index) {
                                  final breed = canineProvider.petBreeds[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: horizontalPadding.w,
                                        right: horizontalPadding.w,
                                        bottom: 10),
                                    child: BreedItem(
                                        item: breed.name,
                                        onTap: () {
                                          canineProvider
                                              .updateSelectedBreed(breed);
                                          Navigator.pop(context);
                                        },
                                        isSelected:
                                            canineProvider.selectedBreed ==
                                                breed),
                                  );
                                }),
                          ),
              ],
            );
          }));
    },
  );
}

class BreedItem extends StatelessWidget {
  final String item;
  final VoidCallback onTap;
  final bool isSelected;
  const BreedItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainerButton(
      onTap: onTap,
      title: "",
      borderColor: isSelected ? mainColor : const Color(0xFFCCCCCC),
      borderRadius: 12,
      bgColor: isSelected ? const Color(0xFFFBF5F0) : white,
      widget: Row(
        children: [
          Expanded(
              child: BodyTextPrimaryWithLineHeight(
            text: item,
            textColor: isSelected ? mainColor : const Color(0xFF0C0C0C),
          )),
          SvgPicture.asset(isSelected ? genderSelectedIcon : uncheckedIconSvg)
        ],
      ),
    );
  }
}
