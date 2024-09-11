// import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/first_step_account_creation.dart';
import '../models/hive_models/hive_user_model.dart';
import '../models/user_model.dart';
import '../models/user_profile_model.dart';
import '../resources/constants/connectivity.dart';
import '../resources/constants/endpoints.dart';
import '../resources/constants/string_constants.dart';
import '../resources/navigation_utils.dart';
import '../services/api_client.dart';
import '../ui/confirm_email/confirm_email_screen.dart';

class AuthProvider extends ChangeNotifier {
  bool _isDogOwner = true;
  bool get isDogOwner => _isDogOwner;

  void updateIsDogOwner(bool newValue) {
    _isDogOwner = newValue;
    notifyListeners();
  }

  FirstStepAccountCreation? _firstStepAccountCreation;
  FirstStepAccountCreation? get firstStepAccountCreation =>
      _firstStepAccountCreation;

  void updateFirstStepAccountCreation(
      FirstStepAccountCreation? firstStepAccountCreation) {
    _firstStepAccountCreation = firstStepAccountCreation;
    notifyListeners();
  }

  String _resMessage = "";
  String get resMessage => _resMessage;
  void clear() {
    _resMessage = "";
    notifyListeners();
  }

  String _emailForPasswordReset = "";
  String get emailForPasswordReset => _emailForPasswordReset;

  void updateEmailForPasswordReset({String newEmail = ""}) {
    _emailForPasswordReset = newEmail;
    notifyListeners();
  }

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  HiveUserModel? _hiveUserData;
  HiveUserModel? get hiveUserData => _hiveUserData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // Login User
  Future<bool> loginUser({
    required String email,
    required String password,
    required BuildContext context,
    bool isPasscode = false,
  }) async {
    /// Clear previous user info
    // await clearHiveData();

    bool isLoggedIn = false;
    final connected = await connectionChecker();

    String url = loginEndpoint;
    if (context.mounted && connected) {
      _isLoading = true;
      notifyListeners();
      final body = {"email": email, "password": password, "type": "password"};

      debugPrint("The response body is: $body");

      (bool, String) loginRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: true,
          requestName: "Login");

      if (loginRequest.$1) {
        ///The user is logged in
        isLoggedIn = true;
        _isLoading = false;
        _userModel = userModelFromJson(loginRequest.$2);

        HiveUserModel hiveUserModel = HiveUserModel(
            userId: _userModel?.user.id,
            fullName: _userModel?.user.details.name,
            email: _userModel?.user.email,
            token: _userModel?.token,
            phoneNumber: _userModel?.user.details.phoneNumber,
            userName: _userModel?.user.details.username,
            address: _userModel?.user.details.address,
            vcn: _userModel?.user.details.vcn,
            role: _userModel?.user.role);
        _hiveUserData = hiveUserModel;

        Hive.box<HiveUserModel>(userBox)
            .put(hiveUserModel.userId, hiveUserModel);
        isLoggedIn = true;
        _isLoading = false;

        //GET USER PROFILE
        if (context.mounted) {
          getProfile(context: context);
        }
        notifyListeners();
      } else if (loginRequest.$2 == "Email must be verified") {
        _resMessage = loginRequest.$2;
        _isLoading = false;
        _emailForPasswordReset = email;
        notifyListeners();
        if (context.mounted) {
          requestOTP(email: email, context: context);
          navToWithScreenName(
              context: context, screen: const ConfirmEmailScreen());
        }
      } else {
        _resMessage = loginRequest.$2;
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
    }
    return isLoggedIn;
  }

  bool _verifyingOTP = false;
  bool get isVerifyingOTP => _verifyingOTP;
  Future<bool> verifyOTP(
      {required String otp,
      required BuildContext context,
      String verificationOption = "verification"}) async {
    bool isVerified = false;
    final connected = await connectionChecker();
    String url = verifyOtpEndpoint;
    if (context.mounted && connected) {
      _verifyingOTP = true;
      notifyListeners();
      final body = {"otp": otp, "type": verificationOption};
      (bool, String) verifyOTPRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: false,
          requestName: "Verify OTP");

      if (verifyOTPRequest.$1) {
        isVerified = true;
        _verifyingOTP = false;
        isVerified = true;
        notifyListeners();
      } else {
        _resMessage = verifyOTPRequest.$2;
        _verifyingOTP = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _verifyingOTP = false;
      notifyListeners();
    }
    return isVerified;
  }

  bool _resettingPassword = false;
  bool get resettingPassword => _resettingPassword;
  Future<bool> resetPassword(
      {required BuildContext context, required String newPassword}) async {
    bool isVerified = false;
    final connected = await connectionChecker();
    String url = resetPasswordEndpoint;
    if (context.mounted && connected) {
      _resettingPassword = true;
      notifyListeners();
      final body = {
        "email": _emailForPasswordReset,
        "password": newPassword,
        "password_confirmation": newPassword
      };
      (bool, String) resetPasswordRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: false,
          requestName: "Change Password");

      if (resetPasswordRequest.$1) {
        isVerified = true;
        _resettingPassword = false;
        isVerified = true;
        notifyListeners();
      } else {
        _resMessage = resetPasswordRequest.$2;
        _resettingPassword = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _resettingPassword = false;
      notifyListeners();
    }
    return isVerified;
  }

  bool _requestingForgotPassword = false;
  bool get requestingForgotPassword => _requestingForgotPassword;
  Future<bool> forgotPassword({
    required BuildContext context,
  }) async {
    bool requestSent = false;
    final connected = await connectionChecker();
    String url = forgotPasswordEndpoint;
    if (context.mounted && connected) {
      _requestingForgotPassword = true;
      notifyListeners();
      final body = {
        "email": _emailForPasswordReset,
      };
      (bool, String) verifyOTPRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: true,
          requestName: "Forgot Password");

      if (verifyOTPRequest.$1) {
        requestSent = true;
        _requestingForgotPassword = false;
        requestSent = true;
        notifyListeners();
      } else {
        _resMessage = verifyOTPRequest.$2;
        _requestingForgotPassword = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _requestingForgotPassword = false;
      notifyListeners();
    }
    return requestSent;
  }

  bool _requestingOTP = false;
  bool get requestingOTP => _requestingOTP;
  Future<bool> requestOTP({
    required String email,
    required BuildContext context,
  }) async {
    bool isVerified = false;
    final connected = await connectionChecker();
    String url = resendOtpEndpoint;
    if (context.mounted && connected) {
      _requestingOTP = true;
      notifyListeners();
      final body = {"email": email, "purpose": "verification"};
      (bool, String) verifyOTPRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: true,
          requestName: "Request OTP");

      if (verifyOTPRequest.$1) {
        isVerified = true;
        _requestingOTP = false;
        isVerified = true;
        notifyListeners();
      } else {
        _resMessage = verifyOTPRequest.$2;
        _requestingOTP = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _requestingOTP = false;
      notifyListeners();
    }
    return isVerified;
  }

  //REGISTER USER
  Future<bool> registerUser({
    required BuildContext context,
  }) async {
    bool isRegistered = false;
    final connected = await connectionChecker();

    String url =
        _isDogOwner ? createCustomerEndpoint : createVetAccountEndpoint;
    if (context.mounted && connected) {
      _isLoading = true;
      notifyListeners();
      final customerBody = {
        "fullName": _firstStepAccountCreation?.fullName ?? "",
        "email": _firstStepAccountCreation?.email ?? "",
        "phoneNumber": _firstStepAccountCreation?.phoneNumber ?? "",
        "password": _firstStepAccountCreation?.password ?? "",
        "country": 1
      };

      final vetBody = {
        "email": _firstStepAccountCreation?.email ?? "",
        "fullName": _firstStepAccountCreation?.fullName ?? "",
        "phoneNumber": _firstStepAccountCreation?.phoneNumber ?? "",
        "country": 1,
        "vcnNumber": _firstStepAccountCreation?.vcn ?? "",
        "password": _firstStepAccountCreation?.password ?? ""
      };

      (bool, String) registerUserRequest = await ApiClient().postRequest(url,
          context: context,
          body: _isDogOwner ? customerBody : vetBody,
          printResponseBody: false,
          requestName: "Registration");

      if (registerUserRequest.$1) {
        ///The user is logged in
        isRegistered = true;
        _isLoading = false;
        isRegistered = true;
        _isLoading = false;
        _firstStepAccountCreation = null;
        notifyListeners();
      } else {
        _resMessage = registerUserRequest.$2;
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
    }
    return isRegistered;
  }

  //Change Password
  bool _changingPassword = false;
  bool get changingPassword => _changingPassword;
  Future<bool> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    bool passwordChanged = false;
    final connected = await connectionChecker();

    String url = changePasswordEndpoint;
    if (context.mounted && connected) {
      _changingPassword = true;
      notifyListeners();
      final body = {
        "old_password": oldPassword,
        "password": newPassword,
        "password_confirmation": newPassword
      };
      (bool, String) changePasswordRequest = await ApiClient().postRequest(url,
          context: context,
          body: body,
          printResponseBody: false,
          requestName: "Change Password");

      if (changePasswordRequest.$1) {
        ///The user is logged in
        passwordChanged = true;
        _changingPassword = false;
        passwordChanged = true;
        _isLoading = false;
        _firstStepAccountCreation = null;
        notifyListeners();
      } else {
        _resMessage = changePasswordRequest.$2;
        _changingPassword = false;
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _changingPassword = false;
      notifyListeners();
    }
    return passwordChanged;
  }

  UserProfileModel? _userProfile;
  UserProfileModel? get userProfile => _userProfile;

  bool _fetchingProfile = false;
  bool get fetchingProfile => _fetchingProfile;

  Future<bool> getProfile({required BuildContext context}) async {
    notifyListeners();
    bool profileFetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (_userProfile == null) {
        _fetchingProfile = true;
        notifyListeners();
      }
      try {
        if (context.mounted) {
          (bool, String) profileRequestFetched = await ApiClient().getRequest(
              getProfileEndpoint,
              context: context,
              printResponseBody: false,
              requestName: "Get Profile");
          if (profileRequestFetched.$1) {
            _userProfile = userProfileModelFromJson(profileRequestFetched.$2);

            profileFetched = true;
            _fetchingProfile = false;
            notifyListeners();
          } else {
            _fetchingProfile = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        _resMessage = "Internet connection is not available";
        _fetchingProfile = false;
        notifyListeners();
      } catch (e) {
        _resMessage = "Please try again";
        _fetchingProfile = false;
        debugPrint("Get User Profile Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _fetchingProfile = false;
      notifyListeners();
    }
    return profileFetched;
  }

  bool _loggingOut = false;
  bool get loggingOut => _loggingOut;
  Future<bool> logOutUser({required BuildContext context}) async {
    notifyListeners();
    bool loggedOut = false;
    final connected = await connectionChecker();
    if (connected) {
      _loggingOut = true;
      notifyListeners();

      try {
        if (context.mounted) {
          (bool, String) logoutRequest = await ApiClient().postRequest(
              getProfileEndpoint,
              context: context,
              printResponseBody: false,
              requestName: "Logout Request",
              body: {});
          if (logoutRequest.$1) {
            loggedOut = true;
            _loggingOut = false;
            notifyListeners();
          } else {
            _loggingOut = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        _resMessage = "Internet connection is not available";
        _loggingOut = false;
        notifyListeners();
      } catch (e) {
        _resMessage = "Please try again";
        _loggingOut = false;
        debugPrint("Logout User Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      _resMessage = "Internet connection is not available";
      _loggingOut = false;
      notifyListeners();
    }
    return loggedOut;
  }
}

List<String> genderOptionList = [
  "Female",
  "Male",
];

List<String> genderOptionListWithBoth = ["Female", "Male", "Both"];
