import 'package:flutter/material.dart';
import 'package:praktikum/view/diproses.dart';
import 'package:praktikum/view/selesai.dart';
import 'package:praktikum/view/terkirim.dart';

class riwayat_pengaduan_page extends StatefulWidget {
  const riwayat_pengaduan_page({super.key});

  @override
  State<riwayat_pengaduan_page> createState() => _RiwayatPengaduan();
}

class _RiwayatPengaduan extends State<riwayat_pengaduan_page>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _controller;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  @override
  void initState() {
    _controller = TabController(
        length: 3, vsync: this); //permasalahan pada vsync : context
    _controller.addListener(_handleTabSelection);
    super.initState();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 248, 248, 248),
          backgroundColor: const Color.fromARGB(255, 255, 253, 253),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                iconSize: 25,
                icon: const Icon(Icons.arrow_back),
                color: const Color.fromARGB(255, 255, 0, 0),
                onPressed: () {
                  // Implement back button functionality
                },
              ),
              const Text(
                "Riwayat Pengaduan",
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
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                DefaultTabController(
                    length: 3,
                    initialIndex: _currentIndex,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                        ),
                        TabBar(
                          isScrollable: true,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          controller: _controller,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          indicatorColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.black,
                          tabs: const [
                            Tab(text: 'Terkirim'),
                            Tab(text: 'Diproses'),
                            Tab(text: 'Selesai')
                          ],
                          onTap: (value) {
                            setState(() {
                              _currentIndex = value;
                            });
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 36),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            controller: _controller,
                            children: const [
                              terkirim_page(),
                              diproses_page(),
                              selesai_page(),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
