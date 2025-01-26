import 'package:flutter/material.dart';
import 'package:screen_send_request/send_requests/Controller/request_service.dart';
import 'package:screen_send_request/send_requests/Data/send_request_model.dart';
import 'package:dio/dio.dart';
import 'package:screen_send_request/send_requests/widgets/dialog_alert.dart';

class SendRequestProvider extends ChangeNotifier {
  SendRequestModel? sendRequestModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendRequestProv(
      BuildContext context,
      String? Title,
      String? Type,
      var StartDate,
      var EndDate,
      int? SubstituteEmployeeId,
      int? EmployeeId,
      var Itinerar) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Send request via the service
      sendRequestModel = await SendRequestService.sendRequest(
        title: Title,
        type: Type,
        startDate: StartDate,
        endDate: EndDate,
        substituteEmployeeId: SubstituteEmployeeId,
        employeeId: EmployeeId,
        itinerar: Itinerar,
      );

      if (sendRequestModel != null && sendRequestModel!.status == true) {
        // Success response
        print("Request sent successfully!");

        DialogHelper.show(
          context,
          "Success",
          sendRequestModel!.message ?? "The request was sent successfully.",
          Colors.green,
        );
      } else if (sendRequestModel != null &&
          sendRequestModel!.status == false) {
        // Handle API error when `status` is false
        DialogHelper.show(
          context,
          "Error",
          sendRequestModel!.message ??
              "An error occurred while sending the request.",
          Colors.red,
        );
      }
    } on DioException catch (dioError) {
      // Extract error message from the API response
      String errorMessage = "An unexpected error occurred.";
      if (dioError.response != null && dioError.response?.data != null) {
        final responseData = dioError.response!.data;
        if (responseData is Map<String, dynamic> &&
            responseData['message'] != null) {
          errorMessage = responseData['message']; // Use API-provided message
        }
      }

      print("Error occurred: $errorMessage");
      DialogHelper.show(
        context,
        "Error",
        errorMessage,
        Colors.red,
      );
    } catch (e) {
      // Handle other exceptions
      print("Error occurred: $e");
      DialogHelper.show(
        context,
        "Error",
        "An unexpected error occurred. Please try again.",
        Colors.red,
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
