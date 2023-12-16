import 'package:e_complaint/views/History_Pengaduan/component/diproses.dart';
import 'package:e_complaint/views/History_Pengaduan/component/selesai.dart';
import 'package:e_complaint/views/History_Pengaduan/component/terkirim.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(_handleTabSelection);
    // getComplaintStatus("Diproses");
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                    Navigator.pushNamed(context, '/news');
                  }),
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
                              const EdgeInsets.symmetric(horizontal: 40),
                          controller: _controller,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                            children: [
                              TerkirimPage(),
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

  String baseUrl = "https://api.govcomplain.my.id";
  final Dio _dio = Dio();

  Future<Response> _fetchComplaintStatus(String status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? "";

      _dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await _dio.get(
        "$baseUrl/user/complaint?page=1",
        queryParameters: {'status': status},
      );

      debugPrint("Ini response ${response.data}");

      return response;
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 401) {
        // Token kadaluwarsa atau tidak valid
        await _refreshToken(); // Panggil metode untuk mendapatkan token baru
        return _fetchComplaintStatus(
            status); // Ulangi panggilan setelah mendapatkan token baru
      } else {
        print("Error fetching data: $error");
        throw error;
      }
    }
  }

  Future<void> _refreshToken() async {
    try {
      // Implementasikan logika untuk mendapatkan token baru
      // Misalnya, lakukan permintaan HTTP untuk mendapatkan token baru
      // Simpan token baru ke SharedPreferences
      // ...
    } catch (error) {
      print("Error refreshing token: $error");
      throw error;
    }
  }
}
