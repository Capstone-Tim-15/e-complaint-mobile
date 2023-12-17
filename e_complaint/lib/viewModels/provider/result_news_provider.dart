import 'package:dio/dio.dart';
import 'package:e_complaint/models/result_news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultNewsProvider with ChangeNotifier {
  final Dio _dio = Dio();

  List<ResultNewsModel> _resultNewsData = [];
  List<ResultNewsModel> get resultNewsData => _resultNewsData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchData(String idCategory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('bearerToken') ?? '';

    String url = 'http://34.128.69.15:8000/user/news/search?title=$idCategory';

    // print(jwt);
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    try {
      _isLoading = true;
      notifyListeners();

      Response response = await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          if (response.data['results'] != null) {
            _resultNewsData = List<ResultNewsModel>.from(
                (response.data['results'] as List)
                    .map((x) => ResultNewsModel.fromJson(x)));
            print('succeed get news data');
          } else {
            _resultNewsData = [];
          }
          print('Success get data');
        } else {
          print('Failed to fetch data. Status code: ${response.statusCode}');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred when fetching: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
