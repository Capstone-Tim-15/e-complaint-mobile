import 'package:dio/dio.dart';
import 'package:e_complaint/models/news.dart';
import 'package:flutter/material.dart' hide Feedback;
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
        'https://api.govcomplain.my.id/user/news',
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
                category: item['category'],
                fullname: item['fullname'],
                photoImage: item['photoImage'],
                title: item['title'],
                content: item['content'],
                date: item['date'],
                imageUrl: item['imageUrl'],
                feedback: (item['feedback'] as List<dynamic>?)
                    ?.map(
                      (feedbackItem) => Feedback(
                        id: feedbackItem['id'],
                        fullname: feedbackItem['fullname'],
                        role: feedbackItem['role'],
                        photoImage: feedbackItem['photoImage'],
                        newsId: feedbackItem['newsId'],
                        content: feedbackItem['content'],
                      ),
                    )
                    .toList(),
                likes: (item['likes'] as List<dynamic>?)
                    ?.map(
                      (likesItem) => Likes(
                        id: likesItem['id'],
                        userId: likesItem['userId'],
                        newsId: likesItem['newsId'],
                        status: likesItem['status'],
                      ),
                    )
                    .toList(),
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

  Future<News?> getNewsById(
      String id, String feedbackCounts, String likesCounts) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final response = await Dio().get(
          'https://api.govcomplain.my.id/user/news/search?id=$id',
          options: Options(
            headers: {'Authorization': 'Bearer $bearerToken'},
          ),
        );

        final dynamic responseData = response.data;
        print('Response Data: $responseData');

        if (responseData != null) {
          final dynamic results = responseData['results'];
          if (results is Map<String, dynamic> && results.isNotEmpty) {
            final Map<String, dynamic> item = results;

            final News newsItem = News(
              id: item['id'],
              adminId: item['adminId'],
              category: item['category'],
              fullname: item['fullname'],
              photoImage: item['photoImage'],
              title: item['title'],
              content: item['content'],
              date: item['date'],
              imageUrl: item['imageUrl'],
              feedback: (item['feedback'] as List<dynamic>?)
                      ?.map(
                        (feedbackItem) => Feedback(
                          id: feedbackItem['id'],
                          fullname: feedbackItem['fullname'],
                          role: feedbackItem['role'],
                          photoImage: feedbackItem['photoImage'],
                          newsId: feedbackItem['newsId'],
                          content: feedbackItem['content'],
                        ),
                      )
                      .toList() ??
                  List<Feedback>.empty(),
              likes: (item['likes'] as List<dynamic>?)
                      ?.map(
                        (likesItem) => Likes(
                          id: likesItem['id'],
                          userId: likesItem['userId'],
                          newsId: likesItem['newsId'],
                          status: likesItem['status'],
                        ),
                      )
                      .toList() ??
                  List<Likes>.empty(),
            );
            return newsItem;
          } else {
            print('Results is either not a Map or is empty');
          }
        } else {
          print('Response data does not contain results');
        }
      } catch (error) {
        print('Error fetching news details: $error');
      }
    }
    return null;
  }

  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<Feedback>> getCommentsByNewsId(String newsId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final response = await Dio().get(
          'https://api.govcomplain.my.id/user/news/feedback/search?news_id=$newsId',
          options: Options(
            headers: {
              'Authorization': 'Bearer $bearerToken',
            },
          ),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data['results'];

          return data
              .map(
                (item) => Feedback(
                  id: item['id'],
                  fullname: item['fullname'],
                  role: item['role'],
                  photoImage: item['photoImage'] ?? '',
                  newsId: item['newsId'],
                  content: item['content'],
                ),
              )
              .toList();
        } else if (response.statusCode == 404) {
          // Handle 404 Not Found error
          print('Feedback Not Found');
          return [];
        } else {
          // Handle other error cases
          print('Error fetching comments. Status code: ${response.statusCode}');
          return [];
        }
      } catch (error) {
        print('Error fetching comments: $error');
        return [];
      }
    }
    return [];
  }

  Future<Feedback?> createFeedback(
    String newsId,
    String content,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final response = await Dio().post(
          'https://api.govcomplain.my.id/user/news/feedback',
          options: Options(
            headers: {'Authorization': 'Bearer $bearerToken'},
          ),
          data: {
            'newsId': newsId,
            'content': content,
          },
        );

        if (response.statusCode == 201) {
          final dynamic responseData = response.data;
          final dynamic results = responseData['results'];

          if (results is Map<String, dynamic> && results.isNotEmpty) {
            final Map<String, dynamic> feedbackData = results;

            final Feedback feedback = Feedback(
              id: feedbackData['id'],
              fullname: feedbackData['fullname'],
              role: feedbackData['role'],
              photoImage: feedbackData['photoImage'] ?? '',
              newsId: feedbackData['newsId'],
              content: feedbackData['content'],
            );

            return feedback;
          } else {
            print('Results is either not a Map or is empty');
          }
        } else {
          print('Error creating feedback. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error creating feedback: $error');
      }
    }
    return null;
  }

  Future<Likes?> createLikes(
    String newsId,
    String status,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final response = await Dio().post(
          'https://api.govcomplain.my.id/user/news/like',
          options: Options(
            headers: {'Authorization': 'Bearer $bearerToken'},
          ),
          data: {
            'newsId': newsId,
            'status': status,
          },
        );

        if (response.statusCode == 200) {
          final dynamic responseData = response.data;
          final dynamic results = responseData['results'];

          if (results is Map<String, dynamic> && results.isNotEmpty) {
            final Map<String, dynamic> likesData = results;

            final Likes likes = Likes(
              id: likesData['id'],
              userId: likesData['userId'],
              newsId: likesData['newsId'],
              status: likesData['status'],
            );

            return likes;
          } else {
            print('Results is either not a Map or is empty');
          }
        } else {
          print('Error creating likes. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error creating likes: $error');
      }
    }
    return null;
  }

  Future<void> deleteLikes(String likeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final response = await Dio().delete(
          'https://api.govcomplain.my.id/user/news/like/$likeId',
          options: Options(
            headers: {'Authorization': 'Bearer $bearerToken'},
          ),
        );

        if (response.statusCode == 200) {
          // Handle successful deletion, if needed
          print('Likes deleted successfully.');
        } else {
          print('Error deleting likes. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error deleting likes: $error');
      }
    }
  }
}
