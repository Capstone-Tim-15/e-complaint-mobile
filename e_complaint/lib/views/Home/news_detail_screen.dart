import 'package:e_complaint/models/news.dart';
import 'package:e_complaint/viewModels/news_view_model.dart';
import 'package:e_complaint/views/Home/click_comment.dart';
import 'package:e_complaint/views/Home/component/news_detail/comment_section.dart';
import 'package:e_complaint/views/Home/component/news_detail/news_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatefulWidget {
  final String id;

  NewsDetail({required this.id});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  News? _news;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Provider.of<NewsViewModel>(context, listen: false)
            .getNewsById(widget.id);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  void getNewsData() async {
    final news = await Provider.of<NewsViewModel>(context, listen: false)
        .getNewsById(widget.id);
    if (news != null) {
      setState(() {
        _news = news;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_news == false) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Postingan Berita',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black),
          ),
          toolbarHeight: 48,
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 236, 123, 115),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 20, 16, 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 21,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/circle_avatar.png',
                                    fit: BoxFit.cover,
                                    width: 42,
                                    height: 42,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Admin',
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            letterSpacing: -0.5),
                                      ),
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                        DateFormat('MM-dd').format(
                                            DateTime.parse(_news!.date)),
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            letterSpacing: -0.5),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Jalan Engku Putri, Kota Batam',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 230, 78, 69),
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              _news!.content,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.5),
                            ),
                          ),
                          'assets/images/news_image.jpg' != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7.78),
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
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {},
                                child:
                                    Image.asset('assets/icons/icon_like.png'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                '1rb',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 153, 153, 153)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenCommentPage(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                    'assets/icons/icon_comment.png'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                '12',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 153, 153, 153)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {},
                                child:
                                    Image.asset('assets/icons/icon_save.png'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                '35',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 153, 153, 153)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {},
                                child:
                                    Image.asset('assets/icons/icon_share.png'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                '1.5rb',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    letterSpacing: -0.5,
                                    color: Color.fromARGB(255, 153, 153, 153)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    CommentSection()
                  ],
                ),
              ),
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey, // Warna bayangan
                    blurRadius: 8, // Radius blur bayangan
                    offset: Offset(0, 2), // Posisi bayangan (x, y)
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const ImageIcon(
                        color: Color.fromARGB(255, 230, 78, 69),
                        AssetImage('assets/icons/icon_camera.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/comment');
                      },
                      child: const Text(
                        'Tambahkan Komentar',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
