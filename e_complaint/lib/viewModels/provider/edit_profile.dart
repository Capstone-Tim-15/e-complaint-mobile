import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EditUserProvider with ChangeNotifier {
  final Dio _dio = Dio();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  void updateUser(
    String userId,
    String userName,
    String newName,
    String newphoneNumber,
    String newEmail,
    String token,
    String password,
  ) async {
    

    String url = 'https://api.govcomplain.my.id/user/$userId';
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> requestBody = {
      'name': newName,
      'username': userName,
      'email': newEmail,
      'phone': newphoneNumber,
      'password': password,
    };

    try {
      Response response = await _dio.put(
        url,
        data: requestBody,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        print('Failed to update user. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An       error occurred: $error');
    }
  }
}
