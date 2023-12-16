import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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
          icon: Icon(Icons.arrow_back, color: Color(0xFFBF0024)),
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

  FAQCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.3,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 12.0, 0.0, 12.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: CircleAvatar(
              backgroundColor: Color(0xFFFFDBCF),
              radius: 12,
              child: Icon(Icons.keyboard_arrow_right, color: Color(0xFFBF0024)),
            ),
            onTap: () {
              // Handle the tap event for the FAQ item
            },
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
