import 'dart:io';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:flutter/material.dart';
import '../models/dashboard_info_model.dart';
import '../resources/constants/connectivity.dart';
import '../services/api_client.dart';

class DashboardProvider extends ChangeNotifier {
  String inboxTab = crossDealTab;

  String resMessage = "";
  void clear() {
    resMessage = "";
    notifyListeners();
  }

  CanineOfTheDay? selectedCanineOfTheDay;

  void updateSelectedCanineOfTheDay(CanineOfTheDay? canineOfTheDay) {
    selectedCanineOfTheDay = canineOfTheDay;
    notifyListeners();
  }

  bool gettingDashboardInfo = false;
  DashboardInfoData? dashboardInfoData;
  Future<bool> getDashboardInfo({
    required BuildContext context,
  }) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (dashboardInfoData == null) {
        gettingDashboardInfo = true;
        notifyListeners();
      }
      String url = "helpers/home/page";

      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(url,
              context: context,
              printResponseBody: false,
              requestName: "getDashboardInfo ");
          gettingDashboardInfo = false;
          if (requestFetched.$1) {
            dashboardInfoData =
                dashboardInfoModelFromJson(requestFetched.$2).data;
            fetched = true;
            notifyListeners();
          } else {
            gettingDashboardInfo = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingDashboardInfo = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingDashboardInfo = false;
        debugPrint("Get Canines Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingDashboardInfo = false;
      notifyListeners();
    }
    return fetched;
  }
}
