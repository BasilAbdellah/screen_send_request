import 'package:dio/dio.dart';
import 'package:screen_send_request/send_requests/Data/get_substitute_employee_model.dart';

class SubstituteEmployeeService {
  static Dio dio = Dio();

  static Future<List<GetSubstituteEmployeeModel>>
      getSubstituteEmployee() async {
    const String baseUrl = 'http://156.214.215.246:8080/api/Employee';
    const String url = '$baseUrl/GetEmployeesByDepartmentName/Elsewedy';

    try {
      final response = await dio.get(url);
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
