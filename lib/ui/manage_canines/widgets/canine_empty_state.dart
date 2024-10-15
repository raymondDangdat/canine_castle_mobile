import 'package:canine_castle_mobile/Widgets/components.dart';
import 'package:canine_castle_mobile/resources/constants/color_constants.dart';
import 'package:canine_castle_mobile/resources/navigation_utils.dart';
import 'package:canine_castle_mobile/ui/manage_canines/add_canine_screen.dart';
import 'package:canine_castle_mobile/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/canine_provider.dart';
import '../../../resources/constants/string_constants.dart';

class CaninesEmptyState extends StatelessWidget {
  const CaninesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 200,
        ),
        const BodyTextPrimaryWithLineHeight(
          text: "You have not added any \ncanine yet",
          alignCenter: true,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
            width: 150,
            child:
                Consumer<CanineProvider>(builder: (ctx, canineProvider, child) {
              return MainButton(
                addCanine,
                textColor: mainColor,
                () {
                  canineProvider.getPetBreeds(context: context);
                  canineProvider.getStatesOrCities(context: context);
                  navToWithScreenName(
                      context: context, screen: const AddCanineScreen());
                },
                color: const Color.fromRGBO(251, 245, 240, 1),
              );
            })),
      ],
    );
  }
}
