
import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:e_complaint/views/Home/component/news/news_screen.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 219, 207),
        title: Container(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/circle_avatar.png',
                    fit: BoxFit.cover,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Text(
                'GOV-Complaint',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              Image.asset('assets/icons/icon_question.png')
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(child: NewsScreen()),
      floatingActionButton: Material(
        elevation: 4,
        color: Colors.transparent,
        shadowColor: Color.fromARGB(255, 236, 123, 115),
        shape: CircleBorder(),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromARGB(255, 236, 123, 115),
          child: Icon(Icons.add),
          // mini: true,
        ),
      ),
    );
  }
}
