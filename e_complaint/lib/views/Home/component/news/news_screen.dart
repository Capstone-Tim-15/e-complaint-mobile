import 'package:e_complaint/models/news.dart';
import 'package:e_complaint/viewModels/news_view_model.dart';
import 'package:e_complaint/viewModels/provider/news.dart';
import 'package:e_complaint/views/Home/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isLiked = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        newsProvider.pagingController.addPageRequestListener((pageKey) {
          newsProvider.getNews(pageKey);
        });
        newsProvider.getNews(1);
      });
    }
  }

  void _refreshNewsList() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.pagingController.refresh();
  }

  Future<void> _likeNews(String newsId) async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    News? newsItem = await newsProvider.getNewsById(newsId, '0', '0');

    if (newsItem != null) {
      if (newsItem.likes?.isNotEmpty == true) {
        bool userLiked = newsItem.likes!.any((like) => like.userId == 'userId');

        // updatedLikeStatus = false;

        if (userLiked) {
          // await newsProvider.deleteLikes(newsItem.likes![0].id);
        } else {
          print('User has not liked this news item.');
        }
      } else {
        print('User cannot dislike a news item they have not liked.');
      }
      await newsProvider.createLikes(newsId, 'LIKE');
      _refreshNewsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return PagedListView<int, News>(
      pagingController: newsProvider.pagingController,
      builderDelegate: PagedChildBuilderDelegate<News>(
        itemBuilder: (context, newsItem, index) {
          String formattedDate = DateFormat('MM-dd').format(
            DateTime.parse(newsItem.date),
          );
          int feedbackCounts = newsItem.feedback?.length ?? 0;
          int likesCounts = newsItem.likes?.length ?? 0;
          newsItem.feedbackCount = feedbackCounts;
          newsItem.likesCount = likesCounts;
          return InkWell(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => NewsDetail(
                    id: newsItem.id,
                    feedbackCounts: newsItem.feedbackCount.toString(),
                    likeCounts: newsItem.likesCount.toString(),
                    onRefresh: _refreshNewsList,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newsItem.photoImage != ''
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 21,
                              child: ClipOval(
                                child: Image.asset(
                                  newsItem.photoImage ?? '',
                                  fit: BoxFit.cover,
                                  width: 42,
                                  height: 42,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 21,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/circle_avatar_admin.png',
                                  fit: BoxFit.cover,
                                  width: 42,
                                  height: 42,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 288,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  newsItem.fullname,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      letterSpacing: -0.5,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  'assets/images/verified_logo.png',
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 204, 204, 204),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              newsItem.title,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                letterSpacing: -0.5,
                                color: Color.fromARGB(255, 102, 102, 102),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            newsItem.imageUrl != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.network(
                                      'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${newsItem.imageUrl}',
                                    ),
                                  )
                                : SizedBox(
                                    height: 0,
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _likeNews(newsItem.id);
                                  },
                                  child:
                                      Image.asset('assets/icons/icon_like.png'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  likesCounts.toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      letterSpacing: -0.5,
                                      color:
                                          Color.fromARGB(255, 153, 153, 153)),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                      'assets/icons/icon_comment.png'),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  feedbackCounts.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 153, 153, 153),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color.fromARGB(255, 191, 191, 191),
                  height: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
