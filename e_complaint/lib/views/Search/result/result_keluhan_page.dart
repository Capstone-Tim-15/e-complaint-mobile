import 'package:e_complaint/viewModels/provider/result_complaint_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultKeluhan extends StatefulWidget {
  final String idCategory;

  const ResultKeluhan({Key? key, required this.idCategory}) : super(key: key);

  @override
  State<ResultKeluhan> createState() => _ResultKeluhanState();
}

class _ResultKeluhanState extends State<ResultKeluhan> {
  late final ResultComplaintProvider resultComplaintProvider;

  @override
  void initState() {
    super.initState();
    resultComplaintProvider = context.read<ResultComplaintProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resultComplaintProvider.fetchData(widget.idCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultComplaintPorvider = Provider.of<ResultComplaintProvider>(context);
    return resultComplaintPorvider.resutComplaintData.isEmpty
        ? Text('tidak ada data')
        : ListView.builder(
            itemCount: resultComplaintPorvider.resutComplaintData.length,
            itemBuilder: (context, index) {
              final complaint = resultComplaintPorvider.resutComplaintData[index];
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: complaint.photoImage != "" &&
                                  complaint.photoImage.isNotEmpty
                              ? NetworkImage(
                                  'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${complaint.photoImage}')
                              : const AssetImage('assets/images/Contact.png')
                                  as ImageProvider,
                          radius: 20,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(complaint.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                const SizedBox(width: 10),
                                Text(
                                  complaint.createdAt != "" &&
                                          complaint.createdAt.isNotEmpty
                                      ? " tanggal ${complaint.createdAt}"
                                      : "2023-12-18",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              complaint.address != "" && complaint.address.isNotEmpty
                                  ? " tanggal ${complaint.address}"
                                  : "Jalan Duyung, Kota Batam",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "content ${complaint.content}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (complaint.imageUrl != "")
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${complaint.imageUrl}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 500,
                        height: 200,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
  }
}
