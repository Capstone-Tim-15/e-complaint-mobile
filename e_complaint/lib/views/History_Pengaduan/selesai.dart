import 'package:flutter/material.dart';
import 'package:praktikum/view/detail_pengaduan.dart';

class selesai_page extends StatelessWidget {
  const selesai_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 200),
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
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
                                      'Keluhan Kesusahan',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Saya telah menghubungi layanan pelanggan Anda beberapa kali, tetapi tidak ada tanggapan atau bantuan yang memadai terkait masalah dengan akun saya.',
                                      softWrap: true,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 10),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  detailPengaduan_page(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Lihat Selengkapnya',
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ]),
              )
            ])));
  }
}
