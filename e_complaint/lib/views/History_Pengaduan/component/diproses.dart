import 'package:dio/dio.dart';
import 'package:e_complaint/views/History_Pengaduan/component/detail_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class diproses_page extends StatefulWidget {
  diproses_page({super.key});

  @override
  State<diproses_page> createState() => _diproses_pageState();
}

class _diproses_pageState extends State<diproses_page> {
  final Dio _dio = Dio();
  List dataComplaintDiproses = [];

  @override
  void initState() {
    // getComplaintStatus("SEND");
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await getComplaintStatus("Diproses");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: dataComplaintDiproses.isEmpty
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
                              itemCount: dataComplaintDiproses.length,
                              itemBuilder: (context, index) {
                                var dataList = dataComplaintDiproses[index];
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
        dataComplaintDiproses = List.from(responseData);
      });
    } catch (error) {
      print("Error fetching data: $error");
      // Handle error gracefully, e.g., show an error message to the user.
      throw error;
    }
  }
}
