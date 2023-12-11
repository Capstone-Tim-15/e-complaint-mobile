import 'package:e_complaint/viewModels/complaint_view_model.dart';
import 'package:e_complaint/models/complaint.dart';
import 'package:e_complaint/views/History_Pengaduan/component/detail_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiprosesPage extends StatelessWidget {
  const DiprosesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ComplaintsViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 200),
                    child: FutureBuilder(
                      future: viewModel.getComplaint(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Complaint> diprosesComplaints = viewModel
                              .getComplaintsByStatus(ComplaintStatus.Diproses);

                          return ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: diprosesComplaints.length,
                            itemBuilder: (context, index) {
                              Complaint complaint = diprosesComplaints[index];

                              return Container(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 17,
                                  left: 20,
                                  right: 20,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(
                                            complaint.title,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            complaint.content,
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(height: 10),
                                          TextButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         DetailPengaduanPage(),
                                              //   ),
                                              // );
                                            },
                                            child: const Text(
                                              'Lihat Selengkapnya',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
