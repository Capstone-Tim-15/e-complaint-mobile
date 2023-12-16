import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileIdProvider {
  final Dio _dio = Dio();

  // Pass the JWT token to this method
  Future<Map<String, dynamic>> getUserByName(String id, String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearerToken');
      Response response = await _dio.get(
        'http://34.128.69.15:8000/user/search?id=$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
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
