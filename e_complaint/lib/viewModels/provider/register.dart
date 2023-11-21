import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool obscureTextKataSandi = true;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final Dio _dio = Dio();

  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var response = await _dio.post(
        'http://34.128.69.15:8000/user/register',
        data: {
          'name': name.text,
          'username': username.text,
          'email': email.text,
          'phone': phone.text,
          'password': password.text,
        },
      );

      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        await Navigator.pushNamed(context, '/succesRegister');
      } else {
        // Handle error appropriately
        print('Registration failed: ${response.statusCode}');
      }
    }
  }

  void togglePasswordVisibility() {
    obscureTextKataSandi = !obscureTextKataSandi;
    notifyListeners();
  }

  String? validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!value.endsWith("@gmail.com")) {
      return 'Harap masukkan akun Gmail';
    }
    return null;
  }
}
