import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Notifikasi());
}

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0.2,
          backgroundColor: const Color.fromARGB(255, 255, 224, 224),
          title: const Text(
            "Notifikasi",
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: MediaQuery.of(context).padding.top + 20),
              DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Color.fromARGB(255, 160, 157, 157),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Tandai Sudah Dibaca (1)',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              height: 3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 200),
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 17, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 160, 157, 157))),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   children: [
                                      //     Text(
                                      //       'Tandai Sudah Dibaca (1)',
                                      //       style: TextStyle(
                                      //         color: Colors.red,
                                      //         fontSize: 13,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Status Pengaduan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                          "Pengaduan anda tentang kerusakan jalan telah diterima. saat ini tim kami sedang meninjau masalah.",
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "1 jam lalu",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 83, 82, 82),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 200),
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 17, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: const Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("30 Menit Yang Lalu",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
