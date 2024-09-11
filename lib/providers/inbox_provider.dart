import 'package:flutter/material.dart';

import '../resources/constants/image_constant.dart';
// import 'package:http/http.dart' as http;

class InboxProvider extends ChangeNotifier {
  bool _isMessagesTab = true;
  bool get isMessagesTab => _isMessagesTab;

  void updateIsDogTab({bool newValue = true}) {
    _isMessagesTab = newValue;
    notifyListeners();
  }

  Request? _selectedRequest;
  Request? get selectedRequest => _selectedRequest;

  void updateSelectedRequest(Request? request) {
    _selectedRequest = request;
    notifyListeners();
  }

  final List<Request> _requests = [
    Request(
        dogImg: request1,
        requestMessage:
            "Hey Mike, I would love to crossbreed my female german shepherd with this your dutchpug",
        dealType: "No Puppy Deal",
        price: "60,000",
        requestUser:
            RequestUser(userName: "Dev Ray", profileImg: devRayProfileImg)),
    Request(
        dogImg: request3,
        requestMessage:
            "Hey Mike, I would love to crossbreed my female german shepherd with this your dutchpug",
        dealType: "No Puppy Deal",
        price: "60,000",
        status: true,
        requestUser: RequestUser(
            userName: "Adamu Musa", profileImg: adamuMusaProfileImg)),
    Request(
        dogImg: request2,
        requestMessage:
            "Hey Mike, I would love to crossbreed my female german shepherd with this your dutchpug",
        dealType: "No Puppy Deal",
        price: "60,000",
        requestUser:
            RequestUser(userName: "Dev Ray", profileImg: devRayProfileImg)),
    Request(
        dogImg: request3,
        requestMessage:
            "Hey Mike, I would love to crossbreed my female german shepherd with this your dutchpug",
        dealType: "No Puppy Deal",
        price: "60,000",
        status: true,
        requestUser: RequestUser(
            userName: "Adamu Musa", profileImg: adamuMusaProfileImg)),
  ];
  List<Request> get requests => _requests;
}

class Request {
  final String dogImg;
  final bool status;
  final String requestMessage;
  final String dealType;
  final String price;
  final RequestUser requestUser;

  Request(
      {required this.dogImg,
      this.status = false,
      required this.requestMessage,
      required this.dealType,
      required this.price,
      required this.requestUser});
}

class RequestUser {
  final String userName;
  final String profileImg;

  RequestUser({required this.userName, required this.profileImg});
}
