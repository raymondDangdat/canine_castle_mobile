import 'dart:io';

import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:canine_castle_mobile/providers/canine_provider.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/constants/dimension_constants.dart';
import 'package:canine_castle_mobile/resources/constants/font_constants.dart';
import 'package:canine_castle_mobile/resources/constants/image_constant.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/modals/pet_breed_selection_modal.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/modals/show_citiy_selection_modal.dart';
import 'package:canine_castle_mobile/ui/manage_canines/widgets/modals/states_selection_modal.dart';
import 'package:canine_castle_mobile/utils/constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:canine_castle_mobile/widgets/constant_widgets.dart';
import 'package:canine_castle_mobile/widgets/custom_appbar.dart';
import 'package:canine_castle_mobile/widgets/label_widget.dart';
import 'package:canine_castle_mobile/widgets/long_divider.dart';
import 'package:canine_castle_mobile/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../resources/constants/string_constants.dart';
import '../../widgets/custom_snack_back.dart';

class AddCanineScreen extends StatefulWidget {
  const AddCanineScreen({super.key});

  @override
  State<AddCanineScreen> createState() => _AddCanineScreenState();
}

class _AddCanineScreenState extends State<AddCanineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final canineProvider =
          Provider.of<CanineProvider>(context, listen: false);
      canineProvider.resetCanineFields();
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child:
              Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (canineProvider.resMessage != '') {
                customSnackBar(context, canineProvider.resMessage);

                ///Clear the response message to avoid duplicate
                canineProvider.clear();
              }
            });
            return Column(
              children: [
                const TopPadding(),
                const CustomAppbar(title: "Add canine"),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BodyTextPrimaryWithLineHeight(
                              text: makeCanineProfilePublic,
                              textColor: blackTextColor,
                              fontWeight: mediumFont,
                            ),
                            InkWell(
                              onTap: () {
                                canineProvider.toggleMakeCanineProfilePublic();
                              },
                              child: SvgPicture.asset(
                                  canineProvider.makeCanineProfilePublic
                                      ? toggleOn
                                      : toggleOff),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CanineImageItem(
                              onTap: () async {
                                final file =
                                    await handleChooseFromGallery(context);
                                if (file != null) {
                                  canineProvider.addOrRemoveCanineImage(
                                      image: file);
                                }
                              },
                              image: canineProvider.canineImages.isEmpty
                                  ? null
                                  : canineProvider.canineImages[0],
                              removeImage: () {
                                canineProvider.addOrRemoveCanineImage(index: 0);
                              },
                            ),
                            CanineImageItem(
                              onTap: () async {
                                final file =
                                    await handleChooseFromGallery(context);
                                if (file != null) {
                                  canineProvider.addOrRemoveCanineImage(
                                      image: file, index: 1);
                                }
                              },
                              image: canineProvider.canineImages.length >= 2
                                  ? canineProvider.canineImages[1]
                                  : null,
                              removeImage: () {
                                canineProvider.addOrRemoveCanineImage(index: 1);
                              },
                            ),
                            CanineImageItem(
                              onTap: () async {
                                final file =
                                    await handleChooseFromGallery(context);
                                if (file != null) {
                                  canineProvider.addOrRemoveCanineImage(
                                      image: file, index: 2);
                                }
                              },
                              image: canineProvider.canineImages.length >= 3
                                  ? canineProvider.canineImages[2]
                                  : null,
                              removeImage: () {
                                canineProvider.addOrRemoveCanineImage(index: 2);
                              },
                            ),
                            CanineImageItem(
                              onTap: () async {
                                final file =
                                    await handleChooseFromGallery(context);
                                if (file != null) {
                                  canineProvider.addOrRemoveCanineImage(
                                      image: file, index: 3);
                                }
                              },
                              image: canineProvider.canineImages.length >= 4
                                  ? canineProvider.canineImages[3]
                                  : null,
                              removeImage: () {
                                canineProvider.addOrRemoveCanineImage(index: 3);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: nameOfCanine),
                        Row(
                          children: [
                            Expanded(
                                child: CustomField("Charles",
                                    canineProvider.nameOfCanineController))
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: gender),
                        Row(
                          children: [
                            GenderSelectionItem(
                                item: male,
                                onTap: () {
                                  canineProvider.updateSelectedGender(male);
                                },
                                isSelected:
                                    canineProvider.selectedGender == male,
                                icon: maleIcon),
                            SizedBox(
                              width: 5.w,
                            ),
                            GenderSelectionItem(
                                item: female,
                                onTap: () {
                                  canineProvider.updateSelectedGender(female);
                                },
                                isSelected:
                                    canineProvider.selectedGender == female,
                                icon: femaleIcon),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const LabelWidget(label: breed),
                        CustomDropdownButton(
                          title: canineProvider.selectedBreed == null
                              ? "Select Breed"
                              : canineProvider.selectedBreed!.name,
                          onTap: () {
                            showPetBreedSelectionModal(context);
                          },
                          textColor: canineProvider.selectedBreed != null
                              ? blackTextColor
                              : labelTextColor,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BodyTextPrimaryWithLineHeight(
                              text: isThisCanineAPedigree,
                              textColor: blackTextColor,
                              fontWeight: mediumFont,
                            ),
                            InkWell(
                              onTap: () {
                                canineProvider.toggleCanineAPedigree();
                              },
                              child: SvgPicture.asset(
                                  canineProvider.isThisCanineAPedigree
                                      ? toggleOn
                                      : toggleOff),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                const LabelWidget(label: state),
                                CustomDropdownButton(
                                  title: canineProvider.selectedState == null
                                      ? "Select State"
                                      : canineProvider.selectedState?.name,
                                  onTap: () {
                                    showStateSelectionModal(context);
                                  },
                                  textColor:
                                      canineProvider.selectedState != null
                                          ? blackTextColor
                                          : labelTextColor,
                                )
                              ],
                            )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                const LabelWidget(label: city),
                                CustomDropdownButton(
                                  title: canineProvider.selectedCity == null
                                      ? "Select City"
                                      : canineProvider.selectedCity?.name,
                                  onTap: () {
                                    if (canineProvider.selectedState == null) {
                                      //   Do nothing
                                    } else {
                                      canineProvider.getStatesOrCities(
                                          context: context,
                                          stateId: canineProvider
                                                  .selectedState?.id
                                                  .toString() ??
                                              "");
                                      showCitySelectionModal(context);
                                    }
                                  },
                                  textColor: canineProvider.selectedCity != null
                                      ? blackTextColor
                                      : labelTextColor,
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: address),
                        Row(
                          children: [
                            Expanded(
                                child: CustomField(
                              "Search your address",
                              canineProvider.addressController,
                              onChange: (value) {
                                debugPrint("Value==== $value");
                                if (value == null || value.toString().isEmpty) {
                                  canineProvider.fetchPlaceSuggestions("",
                                      resetPrediction: true);
                                } else {
                                  canineProvider.fetchPlaceSuggestions(value);
                                  debugPrint("In the else");
                                }
                              },
                            )),
                          ],
                        ),
                        if (canineProvider.placePredictionModel != null &&
                            canineProvider
                                .placePredictionModel!.predictions.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SizedBox(
                              height: (40 *
                                      canineProvider.placePredictionModel!
                                          .predictions.length)
                                  .toDouble(),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: canineProvider
                                      .placePredictionModel?.predictions.length,
                                  itemBuilder: (context, index) {
                                    final place = canineProvider
                                        .placePredictionModel!
                                        .predictions[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: InkWell(
                                        onTap: () {
                                          canineProvider
                                              .getLatLong(place.description);
                                          canineProvider.addressController
                                              .text = place.description;
                                          canineProvider.resetSearchText();
                                          setState(() {});
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      BodyTextPrimaryWithLineHeight(
                                                    text: place.description,
                                                    textColor: blackTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            LongDivider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const LabelWidget(label: description),
                        Row(
                          children: [
                            Expanded(
                                child: CustomField(
                              "Charles is a pure breed German shepard and over 2 years old....",
                              canineProvider.descriptionController,
                              maxLines: 3,
                            )),
                          ],
                        ),
                        if (canineProvider.selectedGender == male)
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const LabelWidget(label: "No Puppy deal "),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: SvgPicture.asset(infoIconCircle),
                                  )
                                ],
                              ),
                              Row(children: [
                                Expanded(
                                    child: CustomField(
                                  "Enter amount to charge for no puppy deal",
                                  canineProvider.noPuppyDealAmountController,
                                  formatters: numbersOnlyFormat,
                                  onChange: (value) {
                                    if (value != null) {
                                      if (value.isNotEmpty) {
                                        var text =
                                            NumberFormat.decimalPattern('en')
                                                .format(int.parse(
                                                    value.replaceAll(',', '')));
                                        canineProvider
                                            .noPuppyDealAmountController
                                            .value = TextEditingValue(
                                          text: text,
                                          selection: TextSelection.collapsed(
                                            offset: text.length,
                                          ),
                                        );
                                      }
                                      setState(() {});
                                    }
                                  },
                                )),
                              ]),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const LabelWidget(
                                      label: "$puppyDeal (Optional)"),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: SvgPicture.asset(infoIconCircle),
                                  )
                                ],
                              ),
                              Row(children: [
                                Expanded(
                                    child: CustomField(
                                  "Enter amount to charge for puppy deal",
                                  canineProvider.puppyDealAmountController,
                                  formatters: numbersOnlyFormat,
                                  onChange: (value) {
                                    if (value != null) {
                                      if (value.isNotEmpty) {
                                        var text =
                                            NumberFormat.decimalPattern('en')
                                                .format(int.parse(
                                                    value.replaceAll(',', '')));
                                        canineProvider.puppyDealAmountController
                                            .value = TextEditingValue(
                                          text: text,
                                          selection: TextSelection.collapsed(
                                            offset: text.length,
                                          ),
                                        );
                                      }
                                      setState(() {});
                                    }
                                  },
                                )),
                              ]),
                            ],
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        canineProvider.addingCanine
                            ? const CupertinoActivityIndicator()
                            : MainButton("Save", () async {
                                if (canineProvider.canineImages.isEmpty) {
                                  customSnackBar(context,
                                      "Upload at least 1 image of your canines");
                                } else if (canineProvider
                                    .nameOfCanineController.text.isEmpty) {
                                  customSnackBar(
                                      context, "Name of canine is required");
                                } else if (canineProvider.selectedBreed ==
                                    null) {
                                  customSnackBar(
                                      context, "Canine breed is required");
                                } else if (canineProvider.selectedState ==
                                    null) {
                                  customSnackBar(context,
                                      "Select state where your canine is");
                                } else if (canineProvider
                                    .addressController.text.isEmpty) {
                                  customSnackBar(
                                      context, "Where is your canine located?");
                                } else if (canineProvider.selectedCity ==
                                    null) {
                                  customSnackBar(
                                      context, "Which city is your canine?");
                                } else if (canineProvider
                                        .descriptionController.text.length <
                                    5) {
                                  customSnackBar(context,
                                      "Provide a good description of your canine");
                                } else if (canineProvider.selectedGender ==
                                        male &&
                                    canineProvider.noPuppyDealAmountController
                                        .text.isEmpty) {
                                  customSnackBar(context,
                                      "What would you want to charge for a no puppy cross deal?");
                                } else {
                                  await canineProvider.addCanine(
                                      context: context);
                                }
                              }),
                        SizedBox(
                          height: bottomPadding.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          })),
    );
  }
}

class CanineImageItem extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final VoidCallback removeImage;
  const CanineImageItem(
      {super.key, this.image, required this.onTap, required this.removeImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: image == null
                ? const DecorationImage(image: AssetImage(canineImgEmptyState))
                : DecorationImage(image: FileImage(image!), fit: BoxFit.cover)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (image != null)
              Positioned(
                  right: -10,
                  top: -10,
                  child: InkWell(
                      onTap: removeImage,
                      child: SvgPicture.asset(removeCanineIcon)))
          ],
        ),
      ),
    );
  }
}

class GenderSelectionItem extends StatelessWidget {
  final String item;
  final VoidCallback onTap;
  final bool isSelected;
  final String icon;
  const GenderSelectionItem(
      {super.key,
      required this.item,
      required this.onTap,
      required this.isSelected,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomContainerButton(
      onTap: onTap,
      title: "",
      borderColor:
          isSelected ? const Color(0xFFFBF5F0) : const Color(0xFFCCCCCC),
      borderRadius: 12,
      bgColor: isSelected ? const Color(0xFFFBF5F0) : white,
      widget: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: isSelected ? mainColor : null,
              ),
              SizedBox(
                width: 5.w,
              ),
              BodyTextPrimaryWithLineHeight(
                text: item,
                textColor: isSelected ? mainColor : const Color(0xFF0C0C0C),
              ),
            ],
          )),
          if (isSelected) SvgPicture.asset(genderSelectedIcon)
        ],
      ),
    ));
  }
}
