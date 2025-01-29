import 'package:dio/dio.dart';
import 'package:screen_send_request/send_requests/Data/get_substitute_employee_model.dart';

class SubstituteEmployeeService {
  static Dio dio = Dio();
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbXBsb3llZUlkIjoiMSIsIkVtcGxveWVlTmFtZSI6ItmF2LXYt9mB2Ykg2LLZg9ix2YrYpyDYqNmD2LHZiSDYs9in2YTZhSIsIkVtcGxveWVlUm9sZSI6Ik1hbmFnZXIiLCJleHAiOjE3Mzk0MjQ3OTYsImlzcyI6IlJlcXVlc3RNYW5hZ2VtZW50U3lzdGVtQmFja0VuZCIsImF1ZCI6IkVMc2V3ZWR5RW1wbG95ZWVzIn0.nGszFpFp9kWXK_4jEPOEaR7AqjNkcIbwCBiMVLXRh2I';
  static Future<List<GetSubstituteEmployeeModel>>
      getSubstituteEmployee() async {
    const String baseUrl =
        'http://requests-management-system.runasp.net/api/Employee';
    const String url = '$baseUrl/GetEmployeesByDepartmentName/Quality';

    try {
      final response = await dio.get(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        // Parse the JSON response into a list of Employee objects
        List<GetSubstituteEmployeeModel> employees = (response.data as List)
            .map((json) => GetSubstituteEmployeeModel.fromJson(json))
            .toList();
        return employees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }
}
