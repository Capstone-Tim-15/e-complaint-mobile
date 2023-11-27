// login_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  final Dio _dio = Dio();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get rememberMe => _rememberMe;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  Future<Response> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'http://34.128.69.15:8000/user/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      return response;
    } catch (error) {
      print('Error during login: $error');
      return Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: ''),
      );
    }
  }
}
