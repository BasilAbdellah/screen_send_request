import 'package:dio/dio.dart';
import 'package:screen_send_request/send_requests/Data/send_request_model.dart';

class SendRequestService {
  static Dio dio = Dio();
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBsb3llZUlkIjoiMSIsIkVtcGxveWVlTmFtZSI6ItmF2LXYt9mB2Ykg2LLZg9ix2YrYpyDYqNmD2LHZiSDYs9in2YTZhSIsIkVtcGxveWVlUm9sZSI6Ik1hbmFnZXIiLCJleHAiOjE3Mzk0MjQ3OTYsImlzcyI6IlJlcXVlc3RNYW5hZ2VtZW50U3lzdGVtQmFja0VuZCIsImF1ZCI6IkVMc2V3ZWR5RW1wbG95ZWVzIn0.nGszFpFp9kWXK_4jEPOEaR7AqjNkcIbwCBiMVLXRh2I';
  static Future<dynamic> sendRequest(
      {String? title,
      String? type,
      DateTime? startDate,
      DateTime? endDate,
      int? substituteEmployeeId,
      int? employeeId,
      String? itinerar}) async {
    const String baseUrl = 'http://requests-management-system.runasp.net/api';
    const String url = '$baseUrl/Transaction/PostTransaction';

    try {
      var response = await dio.post(url,
          data: {
            "Title": title,
            "Type": type,
            "StartDate": startDate?.toIso8601String(),
            "EndDate": endDate?.toIso8601String(),
            "SubstituteEmployeeId": substituteEmployeeId,
            "EmployeeId": employeeId,
            "Itinerar": itinerar,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        return SendRequestModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        return SendRequestModel.fromJson(response.data);
      } else {
        String errorMessage =
            response.data['message'] ?? 'Unknown error occurred.';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
