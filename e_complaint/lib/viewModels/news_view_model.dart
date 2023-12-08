import 'package:e_complaint/models/news.dart';
import 'package:e_complaint/viewModels/provider/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsViewModel with ChangeNotifier {
  List<News> _news = [];
  List<News> get news => _news;

  Future<void> getAllNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      final newsProvider = NewsProvider(bearerToken: bearerToken);
      await newsProvider.getNews();
      _news = newsProvider.newsList;
      notifyListeners();
    }
  }

  Future<News?> getNewsById(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      final newsProvider = NewsProvider(bearerToken: bearerToken);
      await newsProvider.getNews();

      final newsItem = newsProvider.newsList.firstWhere(
        (news) => news.id == id,
        orElse: () => News(
            id: id,
            adminId: '',
            title: '',
            content: '',
            date: '',
            feedback: '',
            like: ''),
      );
      return newsItem;
    }
    return null;
  }
}
