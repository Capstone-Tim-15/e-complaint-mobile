import 'package:dio/dio.dart';
import 'package:e_complaint/models/news_search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsSearchProvider with ChangeNotifier {
  final Dio _dio = Dio();

  List<NewsSearchModel> _newsSearchData = [];
  List<NewsSearchModel> get newsSearchData => _newsSearchData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('bearerToken') ?? '';

    String url = 'http://34.128.69.15:8000/user/news';

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
        _newsSearchData = List<NewsSearchModel>.from(
            (response.data['results'] as List)
                .map((x) => NewsSearchModel.fromJson(x)));
        print('Succes get data');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
