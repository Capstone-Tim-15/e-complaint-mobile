import 'package:flutter/material.dart';
import 'package:praktikum/view/detail_pengaduan.dart';

class diproses_page extends StatelessWidget {
  const diproses_page({super.key});

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
                      itemCount: 10,
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
                                      'Keluhan Infrastruktur',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Jalan di sekitar sini rusak parah! Banyak lubang bikin bahaya buat kendaraan. Tolong diperbaiki secepatnya dong biar nggak berisiko kecelakaan',
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
                                      ),
                                    )
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
