import 'package:dio/dio.dart';
import 'package:screen_send_request/Core/errors/error_model.dart';
import 'package:screen_send_request/Core/errors/exceptions.dart';
import 'package:screen_send_request/send_requests/Data/send_request_model.dart';

class SendRequestService {
  static Dio dio = Dio();

  static Future<SendRequestModel> sendRequest(
      String? Title,
      String? Type,
      var StartDate,
      var EndDate,
      int? SubstituteEmployeeId,
      int? EmployeeId,
      var Itinerar) async {
    const url = 'http://41.35.237.81:8080/api/Transaction/PostTransaction ';

    var response = await dio.post(url,
        data: {
          "Title": Title,
          "Type": Type,
          "StartDate": StartDate,
          "EndDate": EndDate,
          "SubstituteEmployeeId": SubstituteEmployeeId,
          "EmployeeId": EmployeeId,
          "Itinerar": Itinerar
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ));
    if (response.statusCode == 200) {
      return SendRequestModel.fromJson(response.data);
    } else {
      throw ServerException(errModel: ErrorModel.responseInfo(response));
    }
  }
}
