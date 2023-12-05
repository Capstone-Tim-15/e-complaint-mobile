import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(color: Colors.black, fontFamily: 'Nunito')),
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
        child: Column(
          children: <Widget>[
            FAQCard(question: 'Bagaimana caranya mengajukan keluhan di Aplikasi Gov-Complaint?'),
            FAQCard(question: 'Berapa lama proses pengaduan akan di tinjau?'),
            FAQCard(question: 'Apakah saya bisa melihat status progres keluhan saya?'),
            FAQCard(question: 'Bisakah saya meminta bantuan Customer Service untuk mengajukan pengaduan?'),
            FAQCard(question: 'Apakah data pribadi saya aman ketika saya menggunakan aplikasi Gov-Complaint?'),
            // Add more cards for additional questions
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class FAQCard extends StatelessWidget {
  final String question;

  FAQCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 9.0), // Gap between cards
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Corner radius
        ),
        elevation: 0.3, // This adds a subtle shadow beneath the card
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 12.0, 0.0, 12.0), // Padding inside the card
          child: ListTile(
            title: Text(
              question,
              style: TextStyle(
                fontFamily: 'Nunito', // Specify the font family as Nunito
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: CircleAvatar(
              backgroundColor: Color(0xFFFFDBCF), // Circle color
              radius: 12,
              child: Icon(Icons.keyboard_arrow_right, color: Color(0xFFBF0024)), // Arrow color
            ),
            onTap: () {
              // Handle the tap event for the FAQ item
              // to show answers or navigate to a detailed page
            },
          ),
        ),
      ),
    );
  }
}
