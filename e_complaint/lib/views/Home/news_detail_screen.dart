import 'package:e_complaint/views/Home/component/news_detail/comment_section.dart';
import 'package:e_complaint/views/Home/component/news_detail/news_section.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
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
                children: [NewsSection(), CommentSection()],
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
                    onTap: () {},
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
