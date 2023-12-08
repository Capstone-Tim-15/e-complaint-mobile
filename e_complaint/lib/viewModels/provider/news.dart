import 'package:dio/dio.dart';
import 'package:e_complaint/models/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsProvider extends ChangeNotifier {
  final String bearerToken;

  NewsProvider({required this.bearerToken});

  List<News> _newsList = [];

  List<News> get newsList => _newsList;

  Future<void> getNews() async {
    if (bearerToken.isEmpty) {
      print('Bearer token is empty');
      return;
    }
    try {
      final response = await Dio().get(
        'https://api.govcomplain.my.id/users/news',
        options: Options(headers: {'Authorization': 'Bearer $bearerToken'}),
      );

      final List<dynamic> data = response.data['results'];

      _newsList = data
          .map(
            (item) => News(
              id: item['id'],
              adminId: item['adminId'],
              title: item['title'],
              content: item['content'],
              date: item['date'],
              feedback: item['feedback'] ?? '',
              like: item['likes'] ?? '',
            ),
          )
          .toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  Future<String?> getAdminNameById(String adminId) async {
    try {
      final response = await Dio().get(
        'https://api.govcomplain.my.id/admin/$adminId',
        options: Options(headers: {'Authorization': 'Bearer $bearerToken'}),
      );
      final Map<String, dynamic> adminData = response.data;
      return adminData['name'];
    } catch (error) {
      print('Error fetching admin details: $error');
      return null;
    }
  }

  Future<void> searchNews(String query) async {
    try {
      final response = await Dio().get(
        'https://api.govcomplain.my.id/news/search?id=$query',
        queryParameters: {'id': query},
      );
      final List<dynamic> data = response.data['results'];
      _newsList = data
          .map(
            (item) => News(
              id: item['id'],
              adminId: item['adminId'],
              title: item['title'],
              content: item['content'],
              date: item['date'],
              feedback: item['feedback'],
              like: item['like'],
            ),
          )
          .toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching news: $error');
    }
  }
}
