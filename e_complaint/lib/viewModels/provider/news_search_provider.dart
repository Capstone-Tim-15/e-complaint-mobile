import 'package:dio/dio.dart';
import 'package:e_complaint/models/news_search_model.dart';
import 'package:flutter/foundation.dart';

class NewsSearchProvider with ChangeNotifier {
  List<NewsSearchModel> _newsSearchData = [];

  final Dio _dio = Dio();

  List<NewsSearchModel> get newsSearchData => _newsSearchData;

  void fetchData(String jwt) async {
    String url = 'http://34.128.69.15:8000/users/news';

  print(jwt);
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    };

    try {
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
        print(_newsSearchData);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    } finally {
      notifyListeners();
    }
  }
}
