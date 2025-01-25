import 'package:dio/dio.dart';
import 'package:screen_send_request/Core/Utils/settings/endpoints.dart';
import 'package:screen_send_request/Core/local_storage/cash_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await AuthServiceJWT.getToken(ApiKey.tokenKey);

    options.headers = {
      'Authorization': token != null ? 'Bearer $token' : null,
      'Content-Type': 'application/json',
    };

    super.onRequest(options, handler);
  }
}
