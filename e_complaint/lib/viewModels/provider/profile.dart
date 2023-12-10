// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

class ProfileProvider {
  final Dio _dio = Dio();

  // Pass the JWT token to this method
  Future<Map<String, dynamic>> getUserByName(
      String name, String jwtToken) async {
    try {
      Response response = await _dio.get(
        'http://34.128.69.15:8000/user/search?name=$name',
        options: Options(
          headers: {'Authorization': 'Bearer $jwtToken'},
        ),
      );

      if (response.statusCode == 200) {
        var userData = response.data['name'];
        return response.data;
      } else {
        return {'error': 'Failed to get user data'};
      }
    } catch (error) {
      print('Error during getUserByName: $error');
      return {'error': 'Failed to get user data'};
    }
  }
}
