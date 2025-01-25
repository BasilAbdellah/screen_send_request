import 'package:flutter/material.dart';
import 'package:screen_send_request/send_requests/Controller/request_service.dart';
import 'package:screen_send_request/send_requests/Data/send_request_model.dart';

class SendRequestProvider extends ChangeNotifier {
  SendRequestModel? sendRequestModel;

  Future<void> sendRequestProv(
      String? Title,
      String? Type,
      var StartDate,
      var EndDate,
      int? SubstituteEmployeeId,
      int? EmployeeId,
      var Itinerar) async {
    sendRequestModel = await SendRequestService.sendRequest(Title, Type,
        StartDate, EndDate, SubstituteEmployeeId, EmployeeId, Itinerar);
    notifyListeners();
  }
}
