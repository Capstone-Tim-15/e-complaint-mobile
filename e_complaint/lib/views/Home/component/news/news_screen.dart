import 'package:e_complaint/views/Home/news_detail_screen.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => const NewsDetail(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        )),
        child: Row(
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
            SizedBox(
              width: 288,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'alex',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            letterSpacing: -0.5,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        '06-20',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            letterSpacing: -0.5,
                            color: Color.fromARGB(255, 204, 204, 204)),
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
                  const Text(
                    'Pelayanannya jelek banget ga tahan pokonya pingin pulang aja.',
                    style: TextStyle(
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
                          borderRadius: BorderRadius.circular(7),
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
            )
          ],
        ),
      ),
    );
  }
}
