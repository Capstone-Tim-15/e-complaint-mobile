import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ResultKeluhan extends StatefulWidget {
  const ResultKeluhan({Key? key}) : super(key: key);

  @override
  State<ResultKeluhan> createState() => _ResultKeluhanState();
}

class _ResultKeluhanState extends State<ResultKeluhan> {
  List<Map<String, dynamic>> posts = [
    {
      'userName': 'Fitriana Sari',
      'userImage': 'https://picsum.photos/200/300.jpg',
      'postDate': DateTime.now().subtract(const Duration(days: 1)),
      'address': 'Jl Bangka Raya',
      'postDescription':
          'SMP Negeri 5 Batam perlu kurikulum dan fasilitas yang lebih baik. Anak-anak kami butuh pendidikan yang lebih canggih. Terima kasih.',
      'postImage': 'https://picsum.photos/seed/picsum/200/300',
      'likes': 10,
      'comments': 5,
      'save': 5,
      'shares': 3,
    },
    {
      'userName': 'User 2',
      'userImage': 'https://picsum.photos/500/300.jpg',
      'postDate': DateTime.now().subtract(const Duration(days: 2)),
      'address': 'Jl Bangka Raya',
      'postDescription': 'This is the second post.',
      'postImage': null, // atau ''
      'likes': 20,
      'comments': 10,
      'save': 5,
      'shares': 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(posts[index]['userImage']),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(posts[index]['userName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('yyyy-MM-dd').format(
                              posts[index]['postDate'],
                            ),
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        posts[index]['address'],
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
                posts[index]['postDescription'],
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              posts[index]['postImage'] != null && posts[index]['postImage'] != ''
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(posts[index]['postImage']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 500,
                      height: 200,
                    )
                  : const SizedBox.shrink(),
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
                  Text('${posts[index]['likes']}'),
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
                  Text('${posts[index]['comments']}'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/save.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('${posts[index]['save']}'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/share.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('${posts[index]['shares']}'),
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
