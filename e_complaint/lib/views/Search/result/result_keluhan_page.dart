import 'package:e_complaint/viewModels/provider/result_complaint_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ResultKeluhan extends StatefulWidget {
  final String idCategory;

  const ResultKeluhan({Key? key, required this.idCategory}) : super(key: key);

  @override
  State<ResultKeluhan> createState() => _ResultKeluhanState();
}

class _ResultKeluhanState extends State<ResultKeluhan> {
  late final ResultComplaintProvider resultProv;

  @override
  void initState() {
    super.initState();
    resultProv = context.read<ResultComplaintProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resultProv.fetchData(widget.idCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // return ListView.builder(
    //   itemCount: posts.length,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       padding: const EdgeInsets.all(10),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               CircleAvatar(
    //                 backgroundImage: NetworkImage(posts[index]['userImage']),
    //                 radius: 20,
    //               ),
    //               const SizedBox(width: 10),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Row(
    //                     children: [
    //                       Text(posts[index]['userName'],
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 20,
    //                           )),
    //                       const SizedBox(width: 10),
    //                       Text(
    //                         DateFormat('yyyy-MM-dd').format(
    //                           posts[index]['postDate'],
    //                         ),
    //                         style: const TextStyle(
    //                           fontSize: 10,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 5,
    //                   ),
    //                   Text(
    //                     posts[index]['address'],
    //                     style: const TextStyle(color: Colors.red),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             posts[index]['postDescription'],
    //             style: const TextStyle(fontSize: 16),
    //           ),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           posts[index]['postImage'] != null && posts[index]['postImage'] != ''
    //               ? Container(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(15.0),
    //                     image: DecorationImage(
    //                       image: NetworkImage(posts[index]['postImage']),
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                   width: 500,
    //                   height: 200,
    //                 )
    //               : const SizedBox.shrink(),
    //           const SizedBox(
    //             height: 10,
    //           ),
    //           Row(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: SvgPicture.asset(
    //                   'assets/icons/like.svg',
    //                   width: 24,
    //                   height: 24,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text('${posts[index]['likes']}'),
    //               const SizedBox(width: 10),
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: SvgPicture.asset(
    //                   'assets/icons/comment.svg',
    //                   width: 24,
    //                   height: 24,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text('${posts[index]['comments']}'),
    //               const SizedBox(width: 10),
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: SvgPicture.asset(
    //                   'assets/icons/save.svg',
    //                   width: 24,
    //                   height: 24,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text('${posts[index]['save']}'),
    //               const SizedBox(width: 10),
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: SvgPicture.asset(
    //                   'assets/icons/share.svg',
    //                   width: 24,
    //                   height: 24,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 width: 10,
    //               ),
    //               Text('${posts[index]['shares']}'),
    //             ],
    //           ),
    //           const Divider(),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
