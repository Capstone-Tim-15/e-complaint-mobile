import 'package:e_complaint/viewModels/provider/news_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResultBerita extends StatefulWidget {
  const ResultBerita({super.key, required String idCategory});

  @override
  State<ResultBerita> createState() => _ResultBeritaState();
}

class _ResultBeritaState extends State<ResultBerita> {
  late final NewsSearchProvider newsSearchProv;

  @override
  void initState() {
    super.initState();
    newsSearchProv = context.read<NewsSearchProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsSearchProv.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsSearchProv = Provider.of<NewsSearchProvider>(context);
    return ListView.builder(
      itemCount: newsSearchProv.newsSearchData.length,
      itemBuilder: (context, index) {
        final news = newsSearchProv.newsSearchData[index];
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: news.photoImage != "" &&
                            news.photoImage.isNotEmpty
                        ? NetworkImage(
                            'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${news.photoImage}')
                        : const AssetImage('assets/images/Contact.png')
                            as ImageProvider,
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(news.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        news.date != "" && news.date.isNotEmpty
                            ? " tanggal ${news.date}"
                            : "2023-12-18",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                news.content,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              if (news.imageUrl != "")
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${news.imageUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 500,
                  height: 200,
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/like.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(news.feedback?.length.toString() ?? '0'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/comment.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(news.likes?.length.toString() ?? '0'),
                  const SizedBox(width: 10),
                ],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
