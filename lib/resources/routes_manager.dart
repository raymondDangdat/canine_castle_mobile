import 'package:flutter/material.dart';
import '../ui/bottom_nav_screens/inbox/request_detail_screen.dart';
import '../ui/bottom_nav_screens/profile/pet_breeder/user_profile_pet.dart';
import '../ui/bottom_nav_screens/profile/vet/user_profile_vet.dart';
import '../ui/bottom_nav_screens/search/search_dog_detail_screen.dart';
import '../ui/forgot_password_flow/forgot_password_screen.dart';
import '../ui/forgot_password_flow/password_changed_successfully_screen.dart';
import '../ui/forgot_password_flow/set_new_password_screen.dart';
import '../ui/forgot_password_flow/verify_email_to_change_password_screen.dart';
import '../ui/get_started_screen/get_started_screen.dart';
import '../ui/splash_screen/splash_screen.dart';
import '../ui/wallet/transfer_screen.dart';
import '../ui/wallet/wallet_screen.dart';
import 'constants/string_constants.dart';

class Routes {
  static const String splashRoute = "/";
  static const getStartedScreen = "/get_started_screen";
  static const signUpScreen = "/sign_up_screen";
  static const loginPasscodeScreen = "/login_passcode_screen";
  static const forgotPasswordScreen = "/forgot_password_screen";
  static const verifyEmailToChangePasswordScreen =
      "/verify_email_to_change_password_screen";
  static const resetPasswordScreen = "/reset_password_screen";
  static const passwordChangedScreen = "/password_changed_screen";

  static const requestDetailScreen = "/request_detail_screen";
  static const searchedDogDetailScreen = "/searched_dog_detail_screen";
  static const userProfilePetScreen = "/user_profile_pet_screen";
  static const userProfileVetScreen = "/user_profile_vet_screen";
  static const walletScreen = "/wallet_screen";
  static const transferScreen = "/transfer_screen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.getStartedScreen:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.verifyEmailToChangePasswordScreen:
        return MaterialPageRoute(
            builder: (_) => const VerifyEmailToChangeScreen());
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const SetNewPasswordScreen());
      case Routes.passwordChangedScreen:
        return MaterialPageRoute(
            builder: (_) => const PasswordChangedSuccessfullyScreen());

      case Routes.requestDetailScreen:
        return MaterialPageRoute(builder: (_) => const RequestDetailScreen());
      case Routes.searchedDogDetailScreen:
        return MaterialPageRoute(
            builder: (_) => const SearchedDogDetailScreen());

      case Routes.userProfilePetScreen:
        return MaterialPageRoute(builder: (_) => const UserProfilePet());
      case Routes.userProfileVetScreen:
        return MaterialPageRoute(builder: (_) => const UserProfileVet());
      case Routes.walletScreen:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case Routes.transferScreen:
        return MaterialPageRoute(builder: (_) => const TransferScreen());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(noRouteFound),
              ),
              body: const Center(
                child: Text(noRouteFound),
              ),
            ));
  }
}
