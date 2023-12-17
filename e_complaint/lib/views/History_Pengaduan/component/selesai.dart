import 'package:dio/dio.dart';
import 'package:e_complaint/views/History_Pengaduan/component/detail_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selesai_page extends StatefulWidget {
  selesai_page({super.key});

  @override
  State<selesai_page> createState() => _selesai_pageState();
}

class _selesai_pageState extends State<selesai_page> {
  final Dio _dio = Dio();
  List dataComplaintSelesai = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await getComplaintStatus("Selesai");
  }

  String baseUrl = "https://api.govcomplain.my.id";

  Future<void> getComplaintStatus(String status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearerToken');

      // Set header bearer token
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Ganti endpoint dengan user/complaint/search?status=SEND
      Response response = await _dio.get(
        "$baseUrl/user/complaint/search",
        queryParameters: {'status': status},
      );

      final responseData = response.data['results'];
      setState(() {
        dataComplaintSelesai = List.from(responseData);
      });
    } catch (error) {
      print("Error fetching data: $error");
      // Handle error gracefully, e.g., show an error message to the user.
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: dataComplaintSelesai.isEmpty
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 200),
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataComplaintSelesai.length,
                              itemBuilder: (context, index) {
                                var dataList = dataComplaintSelesai[index];
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/Contact.png',
                                        width: 45,
                                        height: 90,
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              "${dataList["category"]}",
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${dataList["content"]}",
                                              softWrap: true,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        detailPengaduan_page(
                                                      complaintId:
                                                          dataList['id'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Lihat Selengkapnya',
                                                style: TextStyle(
                                                    color: Colors.red),
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
