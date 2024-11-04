import 'dart:io';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:flutter/material.dart';
import '../models/stud_request_model.dart';
import '../resources/constants/connectivity.dart';
import '../services/api_client.dart';

class InboxProvider extends ChangeNotifier {
  String inboxTab = crossDealTab;

  String resMessage = "";
  void clear() {
    resMessage = "";
    notifyListeners();
  }

  void updateIsCrossDealsTab({String newValue = crossDealTab}) {
    inboxTab = newValue;
    notifyListeners();
  }

  RequestData? _selectedRequest;
  RequestData? get selectedRequest => _selectedRequest;

  void updateSelectedRequest(RequestData? request) {
    _selectedRequest = request;
    notifyListeners();
  }

  String? selectedAvailableDate;

  void updateSelectedAvailableDate(String availableDate) {
    selectedAvailableDate = availableDate;
    notifyListeners();
  }

  bool gettingStudRequest = false;
  List<RequestData> studRequests = [];
  Future<bool> getStudRequests({
    required BuildContext context,
  }) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      gettingStudRequest = true;
      studRequests = [];
      String url = "studs/all";
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(url,
              context: context,
              printResponseBody: false,
              requestName: "Get Stud Requests");
          gettingStudRequest = false;
          if (requestFetched.$1) {
            final studRequestModel =
                studRequestModelFromJson(requestFetched.$2);
            studRequests = studRequestModel.data;
            fetched = true;
            notifyListeners();
          } else {
            gettingStudRequest = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingStudRequest = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingStudRequest = false;
        debugPrint("Get Canines Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingStudRequest = false;
      notifyListeners();
    }
    return fetched;
  }

  bool isErrorMessage = true;

  bool updatingStudRequest = false;
  Future<bool> updateStudRequest(
      {required BuildContext context, required String status}) async {
    final body = {
      "status": status, //'accepted', 'done', 'completed', 'declined',
      "studDate": "$selectedAvailableDate",
      "remarks": selectedRequest!.message
    };

    isErrorMessage = true;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      updatingStudRequest = true;
      String url = "studs/update/${selectedRequest!.slug}";
      debugPrint("Update stud payload::: $body URL:::$url");
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().patchRequest(url,
              context: context,
              printResponseBody: true,
              body: body,
              requestName: "Get Stud Requests");
          updatingStudRequest = false;
          if (requestFetched.$1) {
            fetched = true;
            isErrorMessage = false;
            resMessage = "Stud request updated successfully";
            notifyListeners();
          } else {
            updatingStudRequest = false;
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        updatingStudRequest = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        updatingStudRequest = false;
        debugPrint("Get Canines Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      updatingStudRequest = false;
      notifyListeners();
    }
    return fetched;
  }
}
