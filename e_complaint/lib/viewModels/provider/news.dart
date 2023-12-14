import 'package:dio/dio.dart';
import 'package:e_complaint/models/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsProvider extends ChangeNotifier {
  final String bearerToken;
  static const _pageSize = 10;

  NewsProvider({required this.bearerToken});

  final PagingController<int, News> _pagingController = PagingController(
    firstPageKey: 0,
  );

  PagingController<int, News> get pagingController => _pagingController;

  List<News> _newsList = [];

  List<News> get newsList => _newsList;

  Future<void> getNews(int pageKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken == null || bearerToken.isEmpty) {
      print('Bearer token is empty');
      return;
    }
    try {
      final response = await Dio().get(
        'https://api.govcomplain.my.id/users/news',
        options: Options(headers: {'Authorization': 'Bearer $bearerToken'}),
        queryParameters: {'page': pageKey, 'limit': _pageSize},
      );

      final List<dynamic> data = response.data['results'];
      final isLastPage = data.isEmpty;

      if (isLastPage) {
        _pagingController.appendLastPage([]);
      } else {
        final List<News> newsList = data
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
        print(newsList.toString());
        _pagingController.appendPage(newsList, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
      print('Error fetching news: $error');
    }
  }

  Future<News?> getNewsById(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      final newsProvider = NewsProvider(bearerToken: bearerToken);
      print(newsList.toString());
      await newsProvider.getNews(0);

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
      print('News Item: $newsItem');
      return newsItem;
    }
    return null;
  }

  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<String?> getAdminNameById(String adminId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
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
    } else {
      print('Bearer token is null or empty');
      return null;
    }
  }

  Future<List<String>> getCommentsByNewsId(String newsId) async {
    try {
      final response = await Dio().get(
        'https://api.govcomplain.my.id/users/news/feedback/search?news_id=$newsId',
        options: Options(headers: {'Authorization': 'Bearer $bearerToken'}),
      );

      final List<dynamic> data = response.data['results'];

      return data
          .map(
            (item) => item['Content'].toString(),
          )
          .toList();
    } catch (error) {
      print('Error fetching comments: $error');
      return [];
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
