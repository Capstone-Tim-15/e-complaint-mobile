import 'package:e_complaint/viewModels/provider/result_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ResultBerita extends StatefulWidget {
  final String idCategory;

  const ResultBerita({Key? key, required this.idCategory}) : super(key: key);

  @override
  State<ResultBerita> createState() => _ResultBeritaState();
}

class _ResultBeritaState extends State<ResultBerita> {
  late final ResultNewsProvider resultNewsProvider;

  @override
  void initState() {
    super.initState();
    resultNewsProvider = context.read<ResultNewsProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resultNewsProvider.fetchData(widget.idCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultNewsProvider = Provider.of<ResultNewsProvider>(context);
    return resultNewsProvider.resultNewsData.isEmpty
        ? const Center(child: Text('Tidak dapat menemukan data berita'))
        : ListView.builder(
            itemCount: resultNewsProvider.resultNewsData.length,
            itemBuilder: (context, index) {
              final resultNews = resultNewsProvider.resultNewsData[index];
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: resultNews.photoImage != "" &&
                                  resultNews.photoImage.isNotEmpty
                              ? NetworkImage(
                                  'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${resultNews.photoImage}')
                              : const AssetImage('assets/images/Contact.png')
                                  as ImageProvider,
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(resultNews.fullname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              resultNews.date != "" && resultNews.date.isNotEmpty
                                  ? " ${resultNews.date}"
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
                      resultNews.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      resultNews.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (resultNews.imageUrl != "")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${resultNews.imageUrl}'),
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
                        Text(resultNews.feedback?.length.toString() ?? '0'),
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
                        Text(resultNews.likes?.length.toString() ?? '0'),
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
