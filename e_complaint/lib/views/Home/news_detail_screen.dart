import 'package:e_complaint/models/news.dart';
import 'package:e_complaint/viewModels/news_view_model.dart';
import 'package:e_complaint/viewModels/provider/news.dart';
import 'package:e_complaint/views/Home/click_comment.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatefulWidget {
  final String id;
  final name;
  final content;
  final photoImage;
  final date;
  final imageUrl;
  final feedback;
  final likes;

  NewsDetail(
      {required this.id,
      this.name,
      this.content,
      this.photoImage,
      this.date,
      this.imageUrl,
      this.feedback,
      this.likes});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  News? _news;
  List<Feedback> _comments = [];

  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? bearerToken = prefs.getString('bearerToken');

  //   if (bearerToken != null && bearerToken.isNotEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //       await Provider.of<NewsProvider>(context, listen: false).getNewsById(
  //           widget.id,
  //           widget.name,
  //           widget.photoImage,
  //           widget.content,
  //           widget.date,
  //           widget.imageUrl,
  //           widget.feedback,
  //           widget.likes);
  //       // await getNewsData();
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  void getNewsData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        final news = await newsProvider.getNewsById(
            widget.id,
            widget.name,
            widget.photoImage,
            widget.content,
            widget.date,
            widget.imageUrl,
            widget.feedback,
            widget.likes);
        if (news != null) {
          setState(() async {
            _news = news;
            _comments = await newsProvider.getCommentsByNewsId(news.id) ?? [];
          });
        } else {
          // Handle the case when news is null
        }
      } catch (error) {
        print('Error fetching news: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = <String>['Terbaru', 'Terlama'];
    String dropdownValue = list.first;

    if (_news == null) {
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
                              _news!.photoImage != ''
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 21,
                                      child: ClipOval(
                                        child: Image.asset(
                                          _news!.photoImage,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        _news!.name,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            letterSpacing: -0.5),
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
                                        width: 13,
                                      ),
                                      Text(
                                        DateFormat('MM-dd').format(
                                          DateTime.parse(_news!.date),
                                        ),
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          letterSpacing: -0.5,
                                          color: Color.fromARGB(
                                              255, 204, 204, 204),
                                        ),
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
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              _news!.content,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.5,
                                color: Color.fromARGB(255, 102, 102, 102),
                              ),
                            ),
                          ),
                          _news!.imageUrl != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(7.78),
                                  child: Image.asset(
                                    _news!.imageUrl,
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
                                child:
                                    Image.asset('assets/icons/icon_like.png'),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                _news!.like.toString(),
                                style: const TextStyle(
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
                              Text(
                                _news!.like.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  letterSpacing: -0.5,
                                  color: Color.fromARGB(255, 153, 153, 153),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const ImageIcon(
                              AssetImage('assets/icons/icon_arrow_down.png'),
                            ),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 0,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        buildCommentSection(),
                      ],
                    )
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

  Widget buildCommentSection() {
    print('Feedback Data: ${_news!.feedback}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var feedback in _comments)
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      feedback.fullname,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: -0.5),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 262,
                  child: Text(
                    feedback.content,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.5,
                        fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Balas',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 136, 136, 136),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                  height: 1,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
