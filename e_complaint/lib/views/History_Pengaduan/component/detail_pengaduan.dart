import 'package:flutter/material.dart';

class detailPengaduan_page extends StatelessWidget {
  detailPengaduan_page({super.key});

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 192, 192, 192),
        backgroundColor: const Color.fromARGB(255, 255, 253, 253),
        title: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            IconButton(
              iconSize: 25,
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromARGB(255, 255, 0, 0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              "Postingan Keluhan",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
                      'assets/Contact.png',
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
                        const Text(
                          'Jelita Salsabila',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          'Jalan Engku Putri, Kota Batam',
                          style: TextStyle(fontSize: 14.5, color: Colors.red),
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
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Saya telah Menghubungi layanan pelanggan anda beberapa kali, tetapi tidak ada tanggapan bantuan yang memadai terkait masalah dengan akun saya. ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 50,
                ),
                Column(
                  children: [
                    Image.asset('assets/Ling.png'),
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
                          icon: const Icon(Icons.thumb_up_alt_outlined),
                          onPressed: () {},
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 200),
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 8,
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
                              'assets/Contact.png',
                              width: 45,
                              height: 90,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Jelita Salsabila',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Jalan di sekitar sini rusak parah! Banyak lubang bikin bahaya buat kendaraan. Tolong diperbaiki secepatnya dong biar nggak berisiko kecelakaan',
                                    softWrap: true,
                                    style: TextStyle(color: Colors.grey),
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
                  // Tambahkan logika untuk mengirim komentar
                  // (misalnya, simpan komentar ke penyimpanan atau server)
                  _textEditingController.clear();
                  _focusNode.unfocus();
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
