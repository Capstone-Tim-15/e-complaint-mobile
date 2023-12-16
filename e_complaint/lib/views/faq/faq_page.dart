import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  Dio dio = Dio();
  List<Map<String, dynamic>> faqList = [];
  bool isLoading =
      true; // Tambahkan state untuk menandai apakah sedang loading atau tidak
  String errorMessage =
      ''; // Tambahkan state untuk menyimpan pesan error jika ada

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      Response response =
          await dio.get('https://api.govcomplain.my.id/user/faq');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          faqList = List<Map<String, dynamic>>.from(response.data['results']);
        });
        // Pernyataan berhasil di console
        print('FAQ data fetched successfully!');
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Error fetching FAQ data: Status Code ${response.statusCode}';
        });
        print(errorMessage);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching FAQ data: $e';
      });
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ',
            style: TextStyle(color: Colors.black, fontFamily: 'Nunito')),
        shadowColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage.isNotEmpty
                ? Center(
                    child: Text(errorMessage),
                  )
                : ListView.builder(
                    itemCount: faqList.length,
                    itemBuilder: (context, index) {
                      return FAQCard(
                        title: faqList[index]['title'],
                        content: faqList[index]['content'],
                      );
                    },
                  ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class FAQCard extends StatelessWidget {
  final String title;
  final String content;

  FAQCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9.0),
      child: Card(
        elevation: 2, // Sesuaikan dengan tinggi elevasi yang diinginkan
        shadowColor: Colors.black, // Ganti dengan warna bayangan yang diinginkan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 205, 205, 205),
                blurRadius: 0, // Sesuaikan dengan radius blur yang diinginkan
                offset: Offset(0, 1), // Sesuaikan dengan offset yang diinginkan
              ),
            ],
          ),
          child: ExpansionTileCard(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.5,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              // Tambahkan konten lain sesuai kebutuhan
            ],
            elevation: 0, // Sesuaikan dengan tinggi elevasi yang diinginkan
            borderRadius: BorderRadius.circular(
                10), // Sesuaikan dengan radius sudut yang diinginkan
            expandedTextColor: Colors
                .red, // Ganti dengan warna teks judul saat diperluas yang diinginkan
            baseColor: Colors
                .white, // Ganti dengan warna dasar saat dalam keadaan biasa yang diinginkan
            contentPadding: EdgeInsets.all(
                8), // Sesuaikan dengan padding konten yang diinginkan
          ),
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: FAQPage(),
  ));
}
