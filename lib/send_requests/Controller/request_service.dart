import 'package:dio/dio.dart';
import 'package:screen_send_request/Core/errors/error_model.dart';
import 'package:screen_send_request/Core/errors/exceptions.dart';
import 'package:screen_send_request/send_requests/Data/send_request_model.dart';

class SendRequestService {
  static Dio dio = Dio();
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBsb3llZUlkIjoiMTAwNSIsIkVtcGxveWVlTmFtZSI6IkFtbWFyIiwiRW1wbG95ZWVSb2xlIjoiTWFuYWdlciIsImV4cCI6MTczOTExNzI2OCwiaXNzIjoiUmVxdWVzdE1hbmFnZW1lbnRTeXN0ZW0iLCJhdWQiOiJFTHNld2VkeUVtcGxveWVlcyJ9.K_P63UwizjeRHkicQLbYVAl7B50F9YIiF7qQvP78824';
  static Future<dynamic> sendRequest(
      {String? title,
      String? type,
      DateTime? startDate,
      DateTime? endDate,
      int? substituteEmployeeId,
      int? employeeId,
      String? itinerar}) async {
    const String baseUrl = 'http://156.214.215.246:8080/api';
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
