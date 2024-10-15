import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/pet_breeder_profile_widget.dart';
import 'package:canine_castle_mobile/ui/bottom_nav_screens/profile/widgets/vet_professional_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';

class PetBreederScreen extends StatelessWidget {
  const PetBreederScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (ctx, authProvider, child) {
      return Scaffold(
        body: authProvider.isDogOwner
            ? const PetBreederProfileWidget()
            : const VetProfessionalProfileWidget(),
      );
    });
  }
}
