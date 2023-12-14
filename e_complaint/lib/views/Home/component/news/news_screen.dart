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
        newsProvider.getNews(0);
      });
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
            return FutureBuilder<String?>(
              future: newsProvider.getAdminNameById(newsItem.adminId),
              builder: (context, snapshot) {
                // String adminName = snapshot.data ?? 'Admin';
                return InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(
                          id: newsItem.id,
                          news: newsItem,
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
                            CircleAvatar(
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
                                        // adminName,
                                        'Admin',
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
                                            color: Color.fromARGB(
                                                255, 204, 204, 204)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Jl. Engku Putri Utara , Kota Batam',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 230, 78, 69),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
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
                                  'assets/images/news_image.jpg' != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Image.asset(
                                            'assets/images/news_image.jpg',
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
                                        onTap: () {},
                                        child: Image.asset(
                                            'assets/icons/icon_like.png'),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        newsItem.like.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                            letterSpacing: -0.5,
                                            color: Color.fromARGB(
                                                255, 153, 153, 153)),
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
                                        newsItem.feedback.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          letterSpacing: -0.5,
                                          color: Color.fromARGB(
                                              255, 153, 153, 153),
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
            );
          },
        ));
  }
}
