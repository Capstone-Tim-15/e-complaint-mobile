import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class detailPengaduan_page extends StatefulWidget {
  detailPengaduan_page({super.key});

  @override
  State<detailPengaduan_page> createState() => _detailPengaduan_pageState();
}

class _detailPengaduan_pageState extends State<detailPengaduan_page> {
  Dio _dio = Dio();
  String baseUrl = "https://api.govcomplain.my.id";
  Map<String, dynamic> complaintData = {};

  Future<void> getComplaintById(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";

      // Set header bearer token
      _dio.options.headers['Authorization'] = 'Bearer $token';

      Response response =
          await _dio.get('$baseUrl/user/complaint/search?id=$id');

      if (response.statusCode == 200) {
        final responseData = response.data['results'];
        setState(() {
          complaintData = responseData;
        });
        print("Complaint Data: $complaintData");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
      // Handle error gracefully, e.g., show an error message to the user.
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getComplaintById('ZiMdp8');
    print('$complaintData');
    super.initState();
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
      body: SafeArea(
          child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(children: [
                const SizedBox(
                  height: 1,
                ),
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
                          complaintData['name'],
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          complaintData['category'],
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
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    complaintData['title'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
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
                    Image.asset(
                      'assets/images/news1.png',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                      width: 30,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        const Text('100'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.comment),
                          onPressed: () {
                            _focusNode.requestFocus();
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                        ),
                        const Text('50'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {
                            // Mengonversi informasi dari API menjadi teks yang sesuai untuk dibagikan
                            String shareContent = '''
                            ${complaintData['imageUrl']}
                            ''';
                            // Panggil fungsi share dari package 'share'
                            Share.share(shareContent);
                          },
                        ),
                        const Text('20'),
                      ],
                    ),
                  ],
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
                      itemCount: complaintData.length,
                      itemBuilder: (context, index) {
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
                                'assets/images/Contact.png',
                                width: 45,
                                height: 90,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      complaintData['name'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      complaintData['content'],
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
                                          duration:
                                              const Duration(milliseconds: 300),
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
                      },
                    ),
                  ),
              ]))),
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
                  // Simpan komentar ke server atau tempat penyimpanan yang sesuai di sini

                  // Bersihkan teks di TextField setelah mengirim komentar
                  _textEditingController.clear();
                },
                child: const Text('Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
