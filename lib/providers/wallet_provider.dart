import 'dart:async';
import 'dart:io';
import 'package:canine_castle_mobile/models/initialize_payment_model.dart';
import 'package:canine_castle_mobile/models/retrieved_user_info_model.dart';
import 'package:canine_castle_mobile/models/transaction_model.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../models/subscription_plan_model.dart';
import '../resources/constants/connectivity.dart';
import '../services/api_client.dart';

class WalletProvider extends ChangeNotifier {
  final amountController = TextEditingController();

  bool showBalance = false;
  void toggleShowBalance() {
    showBalance = !showBalance;
    notifyListeners();
  }

  TransactionModel? transactionModel;
  bool gettingTransactions = false;

  TransactionData? selectedTransaction;
  void updateSelectedTransaction(TransactionData? transaction) {
    selectedTransaction = transaction;
    notifyListeners();
  }

  Future<bool> getTransactions({required BuildContext context}) async {
    allTransactions = [];
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "transactions/all",
              context: context,
              printResponseBody: true,
              requestName: "Get Transactions");
          gettingTransactions = false;
          if (requestFetched.$1) {
            // transactionModel = transactionModelFromJson(requestFetched.$2);
            allTransactions = transactionModelFromJson(requestFetched.$2).data;
            fetched = true;
            notifyListeners();
          } else {
            gettingTransactions = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingTransactions = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingTransactions = false;
        debugPrint("Get Transaction Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingTransactions = false;
      notifyListeners();
    }
    return fetched;
  }

  List<SubscriptionPlanData> subscriptionPlans = [];

  bool gettingSubscription = false;
  Future<bool> getSubscriptionPlans(
      {required BuildContext context, bool isPetOwner = true}) async {
    subscriptionPlans = [];
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              isPetOwner
                  ? "plans/all?userType=pet_owners"
                  : "plans/all?userType=vet",
              context: context,
              printResponseBody: true,
              requestName: "Get Subscription Plans");
          gettingSubscription = false;
          if (requestFetched.$1) {
            subscriptionPlans =
                subscriptionPlanModelFromJson(requestFetched.$2).data;
            fetched = true;
            notifyListeners();
          } else {
            gettingSubscription = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingSubscription = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingSubscription = false;
        debugPrint("Get Transaction Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingSubscription = false;
      notifyListeners();
    }
    return fetched;
  }

  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool verifyingTransaction = false;
  bool transactionVerified = false;
  List<TransactionData> allTransactions = [];
  Future<bool> verifyTransaction(
      {required BuildContext context, required String transactionRef}) async {
    transactionVerified = false;
    verifyingTransaction = true;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "transactions/verify/$transactionRef",
              context: context,
              printResponseBody: true,
              requestName: "Verify Transactions");

          verifyingTransaction = false;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            transactionVerified = true;
            notifyListeners();
          } else {
            verifyingTransaction = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        verifyingTransaction = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        verifyingTransaction = false;
        debugPrint("Get Transaction Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      verifyingTransaction = false;
      notifyListeners();
    }
    return fetched;
  }

  InitializePaymentModel? initializePaymentModel;
  bool initializingPayment = false;
  Future<bool> initializePayment({required BuildContext context}) async {
    initializePaymentModel = null;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "amount": amountController.text.replaceAll(",", ""),
      "location": "Abuja"
    };
    if (connected) {
      initializingPayment = true;
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().postRequest(
              "transactions/create",
              context: context,
              printResponseBody: true,
              body: body,
              requestName: "initializePayment");
          initializingPayment = false;
          if (requestFetched.$1) {
            initializePaymentModel =
                initializePaymentModelFromJson(requestFetched.$2);
            fetched = true;
            notifyListeners();
          } else {
            initializingPayment = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        initializingPayment = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        initializingPayment = false;
        debugPrint("initializePayment::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      initializingPayment = false;
      notifyListeners();
    }
    return fetched;
  }

  final walletTagController = TextEditingController();
  bool transferringFund = false;
  Future<bool> transferFund(
      {required BuildContext context, required String pin}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "amount": amountController.text.replaceAll(",", ""),
      "wallet": walletTagController.text,
      "description": "Fund Transfer",
      "location": "Lugbe Abuja",
      "pin": pin
    };
    debugPrint("The payload is::::::::$body");
    if (connected) {
      transferringFund = true;
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().postRequest(
              "transactions/transfer",
              context: context,
              printResponseBody: true,
              body: body,
              requestName: "transferFund");
          transferringFund = false;
          if (requestFetched.$1) {
            fetched = true;
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            transferringFund = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        transferringFund = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        transferringFund = false;
        debugPrint("Transfer Fund Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      transferringFund = false;
      notifyListeners();
    }
    return fetched;
  }

  bool gettingUserDetails = false;
  RetrievedUserInfoModel? retrievedUserInfoModel;
  Future<bool> retrieveUserDetailsFromWalletTag(
      {required BuildContext context}) async {
    retrievedUserInfoModel = null;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {"walletTag": walletTagController.text};
    debugPrint("The payload is::::::::$body");
    if (connected) {
      gettingUserDetails = true;
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().postRequest(
              "helpers/resolve/wallet/tag",
              context: context,
              printResponseBody: true,
              body: body,
              requestName: "retrieveUserDetailsFromWalletTag");
          gettingUserDetails = false;
          if (requestFetched.$1) {
            fetched = true;
            retrievedUserInfoModel =
                retrievedUserInfoModelFromJson(requestFetched.$2);
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            gettingUserDetails = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingUserDetails = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingUserDetails = false;
        debugPrint("Transfer Fund Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingUserDetails = false;
      notifyListeners();
    }
    return fetched;
  }

  Future<bool> createPIN(
      {required BuildContext context, required String pin}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "pin": pin,
    };
    if (connected) {
      notifyListeners();
      try {
        if (connected) {
          showAppLoader(context, message: "Loading...");
          (bool, String) requestFetched = await ApiClient().postRequest(
              "transactions/pin",
              context: context,
              printResponseBody: true,
              body: body,
              requestName: "createPIN");
          popLoader(context: context);
          if (requestFetched.$1) {
            fetched = true;
            notifyListeners();
          } else {
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        debugPrint("initializePayment::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      notifyListeners();
    }
    return fetched;
  }

  String resMessage = "";
  void clear() {
    resMessage = "";
    notifyListeners();
  }
}
