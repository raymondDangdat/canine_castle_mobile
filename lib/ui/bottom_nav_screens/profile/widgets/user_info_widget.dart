import 'package:canine_castle_mobile/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../providers/auth_provider.dart';
import '../../../../resources/constants/color_constants.dart';
import '../../../../resources/constants/font_constants.dart';
import '../../../../resources/constants/image_constant.dart';
import '../../../../resources/navigation_utils.dart';
import '../pet_breeder/user_profile_pet.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
      return InkWell(
        onTap: () {
          navToWithScreenName(context: context, screen: const UserProfilePet());
        },
        child: ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundColor: brown,
              child: BodyTextPrimaryWithLineHeight(
                text: '${authProvider.userProfile?.data.details.name[0]}',
                fontSize: 20,
                fontWeight: semiBoldFont,
                textColor: white,
              ),
            ),
          ),
          title: BodyTextPrimaryWithLineHeight(
            text: '${authProvider.userProfile?.data.details.name}',
            textColor: black,
            fontWeight: mediumFont,
            fontSize: 16,
          ),
          subtitle: BodyTextPrimaryWithLineHeight(
            text: '${authProvider.userProfile?.data.details.username}',
            textColor: foundation,
            fontSize: 13,
            fontWeight: mediumFont,
          ),
          trailing: SvgPicture.asset(arrowIcon),
        ),
      );
    });
  }
}
