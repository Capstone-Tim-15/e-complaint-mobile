import 'package:e_complaint/models/news.dart';
import 'package:e_complaint/viewModels/provider/news.dart';
import 'package:e_complaint/views/Home/click_comment.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class NewsDetail extends StatefulWidget {
  final String id;
  String feedbackCounts;
  String likeCounts;
  final void Function() onRefresh;

  NewsDetail({
    required this.id,
    required this.feedbackCounts,
    required this.likeCounts,
    required this.onRefresh,
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  void _refreshData() async {
    try {
      await getNewsData();

      setState(() {
        _news = _news;
        _comments = _comments;
      });

      widget.feedbackCounts = _comments.length.toString();

      widget.onRefresh();
    } catch (error) {
      print('Error refreshing news details: $error');
    }
  }

  News? _news;
  List<Feedback> _comments = [];

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  Future getNewsData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? bearerToken = prefs.getString('bearerToken');

    if (bearerToken != null && bearerToken.isNotEmpty) {
      try {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        final news = await newsProvider.getNewsById(
          widget.id,
          widget.feedbackCounts,
          widget.likeCounts,
        );
        if (news != null) {
          _news = news;
          _comments = await newsProvider.getCommentsByNewsId(news.id);
          print('News Content: ${_news!.content}');
          print('Comments: ${widget.feedbackCounts}');
          print('Comments: ${widget.likeCounts}');
        } else {
          print('News is null');
        }
      } catch (error) {
        print('Error fetching news2: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = <String>['Terbaru', 'Terlama'];
    String dropdownValue = list.first;
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
      body: FutureBuilder(
        future: getNewsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            _news?.fullname ?? 'Admin',
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
                                          color:
                                              Color.fromARGB(255, 230, 78, 69),
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                      child: Image.network(
                                        'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${_news!.imageUrl}',
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
                                    widget.likeCounts,
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FullScreenCommentPage(
                                            id: widget.id,
                                            onReplyComplete: _refreshData,
                                            onRefresh: widget.onRefresh,
                                          ),
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
                                    widget.feedbackCounts.toString(),
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
                                  AssetImage(
                                      'assets/icons/icon_arrow_down.png'),
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
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
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
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FullScreenCommentPage(
                                  id: widget.id,
                                  onReplyComplete: _refreshData,
                                  onRefresh: widget.onRefresh,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Tambahkan Komentar',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromARGB(127, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    feedback.photoImage != ''
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: ClipOval(
                              child: Image.network(
                                feedback.photoImage,
                                fit: BoxFit.cover,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/circle_avatar_admin.png',
                                fit: BoxFit.cover,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
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
                      ],
                    ),
                  ],
                ),
                const Divider(
                  indent: 32,
                  endIndent: 32,
                  color: Color.fromARGB(127, 0, 0, 0),
                  height: 1,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
