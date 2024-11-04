import 'dart:async';
import 'dart:io';
import 'package:canine_castle_mobile/models/account_name_model.dart';
import 'package:canine_castle_mobile/models/bank_account_model.dart';
import 'package:canine_castle_mobile/models/banks_model.dart';
import 'package:canine_castle_mobile/models/initialize_payment_model.dart';
import 'package:canine_castle_mobile/models/retrieved_user_info_model.dart';
import 'package:canine_castle_mobile/models/transaction_model.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/foundation.dart';
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
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (allTransactions.isEmpty) {
        allTransactions = [];
        gettingTransactions = true;
        notifyListeners();
      }
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

  SubscriptionPlanData? selectedPlan;

  void updateSelectedPlan(SubscriptionPlanData? plan) {
    selectedPlan = plan;
    notifyListeners();
  }

  bool gettingSubscription = false;
  Future<bool> getSubscriptionPlans(
      {required BuildContext context, required String userType}) async {
    subscriptionPlans = [];
    selectedPlan = null;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      gettingSubscription = true;
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "plans/all?userType=$userType",
              context: context,
              printResponseBody: true,
              requestName: "Get Subscription Plans");
          gettingSubscription = false;
          notifyListeners();
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

  void updateSelectedBank(BankData? bank) {
    selectedBank = bank;
    notifyListeners();
  }

  void searchForBank(String query) {
    debugPrint("Query=======$query");
    allBanksToDisplay = reservedBanks
        .where((bank) =>
            bank.name.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void resetBankList() {
    allBanksToDisplay = [];
    notifyListeners();
    allBanksToDisplay.addAll(reservedBanks);
    notifyListeners();
  }

  bool gettingBanks = false;
  List<BankData> allBanksToDisplay = [];
  List<BankData> reservedBanks = [];
  BankData? selectedBank;
  Future<bool> getBanks({required BuildContext context}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      gettingBanks = true;
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "helpers/banks/all",
              context: context,
              printResponseBody: true,
              requestName: "getBanks");
          allBanksToDisplay = [];
          reservedBanks = [];
          gettingBanks = false;
          reservedBanks = bankModelFromJson(requestFetched.$2).data;
          allBanksToDisplay.addAll(reservedBanks);
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingBanks = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingBanks = false;
        debugPrint("Get Transaction Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingBanks = false;
      notifyListeners();
    }
    return fetched;
  }

  void updateSelectedBankAccount(BankAccountData? account) {
    selectedBankAccount = account;
    notifyListeners();
  }

  bool gettingBankAccounts = false;
  List<BankAccountData> allBankAccounts = [];
  BankAccountData? selectedBankAccount;
  Future<bool> getBankAccounts({required BuildContext context}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (allBankAccounts.isEmpty) {
        gettingBankAccounts = true;
        notifyListeners();
      }
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "accounts/all",
              context: context,
              printResponseBody: true,
              requestName: "getBankAccounts");
          allBankAccounts = [];
          gettingBankAccounts = false;
          allBankAccounts = bankAccountModelFromJson(requestFetched.$2).data;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingBankAccounts = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingBankAccounts = false;
        debugPrint("Get Transaction Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingBankAccounts = false;
      notifyListeners();
    }
    return fetched;
  }

  bool activatingSubscription = false;
  Future<bool> activateSubscription(
      {required BuildContext context, required String pin}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "plan": selectedPlan?.id ?? "",
      "location": "Jos",
      "pin": pin
    };
    if (connected) {
      try {
        if (context.mounted) {
          activatingSubscription = true;
          isError = true;
          notifyListeners();
          (bool, String) requestFetched = await ApiClient().postRequest(
              "subscriptions/create",
              context: context,
              body: body,
              printResponseBody: true,
              requestName: "activateSubscription");
          activatingSubscription = false;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            isError = false;
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        activatingSubscription = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        activatingSubscription = false;
        debugPrint("Activate Subscription Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      activatingSubscription = false;
      notifyListeners();
    }
    return fetched;
  }

  bool withdrawing = false;
  Future<bool> withdrawFromWallet(
      {required BuildContext context, required String pin}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "amount": amountController.text.replaceAll(",", ""),
      "account": selectedBankAccount?.id ?? "",
      "description":
          "Withdrawal of ${amountController.text} to ${selectedBankAccount?.accountNumber}",
      "location": "Lugbe Abuja",
      "pin": pin
    };
    if (connected) {
      try {
        if (context.mounted) {
          withdrawing = true;
          isError = true;
          notifyListeners();
          (bool, String) requestFetched = await ApiClient().postRequest(
              "transactions/withdrawals",
              context: context,
              body: body,
              printResponseBody: true,
              requestName: "withdrawFromWallet");
          withdrawing = false;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            isError = false;
            resMessage = "Withdrawn successfully";
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        withdrawing = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        withdrawing = false;
        debugPrint("withdrawFromWallet Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      withdrawing = false;
      notifyListeners();
    }
    return fetched;
  }

  bool addingBankAccount = false;
  Future<bool> addBankAccount(
      {required BuildContext context, required String accountNumber}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "bank": selectedBank?.id ?? "",
      "accountNumber": accountNumber
    };
    if (connected) {
      try {
        if (context.mounted) {
          addingBankAccount = true;
          isError = true;
          notifyListeners();
          (bool, String) requestFetched = await ApiClient().postRequest(
              "accounts/create",
              context: context,
              body: body,
              printResponseBody: true,
              requestName: "addBankAccount");
          addingBankAccount = false;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            isError = false;
            resMessage = "Bank account details added successfully";
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        addingBankAccount = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        addingBankAccount = false;
        debugPrint("Activate Subscription Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      addingBankAccount = false;
      notifyListeners();
    }
    return fetched;
  }

  void resetRetrievedBankInfo() {
    accountNameRetrieved = null;
    notifyListeners();
  }

  bool gettingAccountName = false;
  AccountNameModel? accountNameRetrieved;
  Future<bool> getAccountName(
      {required BuildContext context, required String accountNumber}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "bank": selectedBank?.id ?? "",
      "accountNumber": accountNumber
    };
    accountNameRetrieved = null;
    notifyListeners();
    if (connected) {
      try {
        if (context.mounted) {
          gettingAccountName = true;
          isError = true;
          notifyListeners();
          (bool, String) requestFetched = await ApiClient().postRequest(
              "helpers/banks/account/name",
              context: context,
              body: body,
              printResponseBody: true,
              requestName: "addBankAccount");
          gettingAccountName = false;
          notifyListeners();
          if (requestFetched.$1) {
            accountNameRetrieved = accountNameModelFromJson(requestFetched.$2);
            fetched = true;
            isError = false;
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingAccountName = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingAccountName = false;
        debugPrint("Activate Subscription Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingAccountName = false;
      notifyListeners();
    }
    return fetched;
  }

  bool deletingBankAccount = false;
  Future<bool> deleteBankAccount({required BuildContext context}) async {
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      try {
        if (context.mounted) {
          deletingBankAccount = true;
          isError = true;
          notifyListeners();
          (bool, String) requestFetched = await ApiClient().deleteRequest(
              "accounts/delete/${selectedBankAccount?.id ?? ''}",
              context: context,
              printResponseBody: true,
              requestName: "deleteBankAccount");
          deletingBankAccount = false;
          notifyListeners();
          if (requestFetched.$1) {
            fetched = true;
            isError = false;
            resMessage = "Bank account details removed successfully";
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        deletingBankAccount = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        deletingBankAccount = false;
        debugPrint("Activate Subscription Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      deletingBankAccount = false;
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

  final walletTagController =
      TextEditingController(text: kDebugMode ? "CC277615427" : "");
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
  void resetRetrieveUserInfo() {
    retrievedUserInfoModel = null;
    notifyListeners();
  }

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

  bool creatingPin = false;
  Future<bool> createPIN(
      {required BuildContext context, required String pin}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    isError = true;
    final body = {
      "pin": pin,
    };
    if (connected) {
      creatingPin = true;
      notifyListeners();
      try {
        (bool, String) requestFetched = await ApiClient().postRequest(
            "transactions/pin",
            context: context,
            printResponseBody: true,
            body: body,
            requestName: "createPIN");
        creatingPin = false;
        notifyListeners();
        if (requestFetched.$1) {
          fetched = true;
          isError = false;
          resMessage = "Transaction pin set successfully";
          notifyListeners();
        } else {
          notifyListeners();
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

  bool isError = true;
  String resMessage = "";
  void clear() {
    resMessage = "";
    notifyListeners();
  }
}
