import 'package:flutter/material.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              const Column(
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
                        '06-20',
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
            child: const Text(
              'Pelayanan SIM Keliling untuk Masyarakat Kota Batam, Telah Dibuka, Cek Selengkapnya!',
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
                child: Image.asset('assets/icons/icon_like.png'),
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
                onTap: () {},
                child: Image.asset('assets/icons/icon_comment.png'),
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
                child: Image.asset('assets/icons/icon_save.png'),
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
                child: Image.asset('assets/icons/icon_share.png'),
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
    );
  }
}
