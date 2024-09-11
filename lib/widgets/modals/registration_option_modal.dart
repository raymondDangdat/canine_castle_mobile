import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../resources/constants/color_constants.dart';
import '../../resources/constants/dimension_constants.dart';
import '../../resources/constants/font_constants.dart';
import '../../resources/constants/image_constant.dart';
import '../../resources/constants/string_constants.dart';
import '../../resources/navigation_utils.dart';
import '../../ui/clinic_option_screen/clinic_option_screen.dart';
import '../components.dart';
import '../custom_text.dart';

Future showRegistrationOptionModal(
  BuildContext importedContext, {
  bool isWallet = true,
}) {
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
      return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(modalRadius.r),
                    topRight: Radius.circular(modalRadius.r)),
              ),
              child: Column(
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
                    child: Consumer<AuthProvider>(
                        builder: (ctx, authProvider, child) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SemiBold16px(
                                text: register,
                                fontSize: 22,
                                fontWeight: semiBoldFont,
                                textColor: blackTextColor,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(closeIconSvg))
                            ],
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          const Row(
                            children: [
                              SemiBold16px(
                                text: iWantTiJoinTheCastleAsA,
                                fontSize: 14,
                                fontWeight: mediumFont,
                                textColor: blackTextColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          CustomContainerButton(
                            onTap: () {
                              authProvider.updateIsDogOwner(true);
                            },
                            title: "",
                            borderColor: authProvider.isDogOwner
                                ? mainColor
                                : const Color(0xFFE6E6E6),
                            borderRadius: 11,
                            verticalPadding: 12,
                            horizontalPadding: 16,
                            borderWidth: authProvider.isDogOwner ? 1.5 : 1,
                            widget: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyTextLightWithLineHeight(
                                      text: dogOwner,
                                      fontWeight: semiBoldFont,
                                      fontSize: 16,
                                      textColor: authProvider.isDogOwner
                                          ? const Color(0xFFD89B65)
                                          : blackTextColor,
                                    ),
                                    BodyTextLightWithLineHeight(
                                      text: iOwnDogs,
                                      fontWeight: authProvider.isDogOwner
                                          ? mediumFont
                                          : regularFont,
                                      fontSize: 13,
                                      textColor: authProvider.isDogOwner
                                          ? const Color(0xFFD89B65)
                                          : const Color(0xFF626262),
                                    ),
                                  ],
                                )),
                                SvgPicture.asset(authProvider.isDogOwner
                                    ? checkedIconSvg
                                    : uncheckedIconSvg)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomContainerButton(
                            onTap: () {
                              authProvider.updateIsDogOwner(false);
                            },
                            title: "",
                            borderColor: authProvider.isDogOwner
                                ? const Color(0xFFE6E6E6)
                                : mainColor,
                            borderRadius: 11,
                            verticalPadding: 12,
                            horizontalPadding: 16,
                            borderWidth: !authProvider.isDogOwner ? 1.5 : 1,
                            widget: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const BodyTextLightWithLineHeight(
                                      text: vetProfessional,
                                      fontWeight: semiBoldFont,
                                      fontSize: 16,
                                      textColor: blackTextColor,
                                    ),
                                    BodyTextLightWithLineHeight(
                                      text: iTreatAndCareForDogs,
                                      fontWeight: !authProvider.isDogOwner
                                          ? mediumFont
                                          : regularFont,
                                      fontSize: 13,
                                      textColor: !authProvider.isDogOwner
                                          ? const Color(0xFFD89B65)
                                          : const Color(0xFF626262),
                                    ),
                                  ],
                                )),
                                SvgPicture.asset(authProvider.isDogOwner
                                    ? uncheckedIconSvg
                                    : checkedIconSvg)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          MainButton(confirm, () {
                            Navigator.pop(context);
                            navToWithScreenName(
                                context: context,
                                screen: const ClinicOptionScreen());
                          }),
                          SizedBox(
                            height: bottomPadding.h,
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              )));
    },
  );
}
