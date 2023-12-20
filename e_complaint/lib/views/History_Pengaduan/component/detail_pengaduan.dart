import 'package:e_complaint/viewModels/complaint_detail.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class detailPengaduan_page extends StatefulWidget {
  final String complaintId;

  const detailPengaduan_page({required this.complaintId, Key? key})
      : super(key: key);

  @override
  State<detailPengaduan_page> createState() => _detailPengaduan_pageState();
}

class _detailPengaduan_pageState extends State<detailPengaduan_page> {
  late ComplaintViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ComplaintViewModel>(context, listen: false);
    _viewModel.getComplaintById(widget.complaintId);
  }

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool isTextClosed = true;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 192, 192, 192),
        backgroundColor: const Color.fromARGB(255, 255, 253, 253),
        title: const Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Text(
              "Postingan Keluhan",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 20, 4),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Tambahkan Komentar',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Panggil fungsi postComment dari ViewModel dengan menggunakan complaintId yang sesuai
                  _viewModel.postComment(
                      widget.complaintId, _textEditingController.text);

                  // Bersihkan teks di TextField setelah mengirim komentar
                  _textEditingController.clear();
                },
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ComplaintViewModel>(builder: (context, viewModel, _) {
        // ignore: unnecessary_null_comparison
        if (viewModel.complaintData == null) {
          // Handle loading state
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 25,
                    ),
                    Image.asset(
                      'assets/images/Contact.png',
                      width: 50,
                      height: 130,
                    ),
                    const SizedBox(
                      width: 27,
                      height: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          viewModel.complaintData.name,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          viewModel.complaintData.category,
                          style: const TextStyle(
                              fontSize: 14.5, color: Colors.red),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          DateTime.now().toString().split(' ')[0],
                          style: const TextStyle(
                              fontSize: 13.5, color: Colors.grey),
                        ),
                      ],
                    )),
                  ],
                ),
                Text(
                  viewModel.complaintData.content,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    if (viewModel.complaintData.imageUrl.isNotEmpty)
                      Image.network(
                        'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${viewModel.complaintData.imageUrl}',
                      ),
                    // Tambahkan logika atau widget lain jika tidak ada URL gambar yang valid.
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                      width: 22,
                    ),
                    const Text(
                      'Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isTextClosed
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            size: 42,
                          ),
                          onPressed: () {
                            setState(() {
                              // Toggle nilai isTextClosed
                              isTextClosed = !isTextClosed;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (!isTextClosed)
                  Container(
                    margin: const EdgeInsets.only(bottom: 200),
                    child: ListView.builder(
                        controller: _scrollController,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: viewModel.complaintData.comment.length,
                        itemBuilder: (context, index) {
                          var comment = viewModel.complaintData.comment[index];
                          return Container(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 17,
                              left: 20,
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  comment['role'] == 'admin'
                                      ? 'assets/images/circle_avatar_admin.png'
                                      : 'assets/images/Contact.png',
                                  width: 45,
                                  height: 90,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        comment['fullname'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        comment['message'],
                                        softWrap: true,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _focusNode.requestFocus();
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                        //ingin menambahkan komentar dari text controller
                                        child: const Text('Balas'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
              ],
            ),
          );
        }
      }),
    );
  }
}
