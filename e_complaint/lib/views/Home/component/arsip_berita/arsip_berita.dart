import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../viewModels/news_view_model.dart';
import '../../news_detail_screen.dart';

class ArsipBerita extends StatefulWidget {
  const ArsipBerita({Key? key}) : super(key: key);

  @override
  _ArsipBeritaState createState() => _ArsipBeritaState();
}

class _ArsipBeritaState extends State<ArsipBerita> {
  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<NewsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arsip Berita'),
      ),
      body: ListView.builder(
        itemCount: modelView.getArchivedNews().length,
        itemBuilder: (context, index) {
          final archivedNews = modelView.getArchivedNews()[index];
          String formattedDate = DateFormat('MM-dd').format(
            DateTime.parse(archivedNews.date),
          );

          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => NewsDetail(
              //       id: archivedNews.id,
              //     ),
              //   ),
              // );
            },
            // child: ListTile(
            //   title: Text(archivedNews.title),
            //   subtitle: Text('Admin - $formattedDate'),
            //   leading: CircleAvatar(
            //     radius: 21,
            //     child: ClipOval(
            //       child: Image.asset(
            //         'assets/images/circle_avatar.png',
            //         fit: BoxFit.cover,
            //         width: 42,
            //         height: 42,
            //       ),
            //     ),
            //   ),
            //   // ... Lainnya sesuai kebutuhan tampilan berita
            // ),
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
                      Row(
                        children: [
                          const Text(
                            'Admin',
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                letterSpacing: -0.5,
                                color: Colors.black),
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
                      Text(
                        archivedNews.title,
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
                            onTap: () {
                              Provider.of<NewsViewModel>(context, listen: false)
                                  .removeFromArchive(archivedNews);
                            },
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
          );
        },
      ),
    );
  }
}
