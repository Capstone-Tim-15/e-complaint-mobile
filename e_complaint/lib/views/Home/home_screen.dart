//import 'package:e_complaint/views/widget/bottom_nav.dart';
import 'package:e_complaint/views/ChatAdmin/chat_admin_screen.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: ClipOval(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatAdminScreen()),
                          );
                        },
                        icon: const Icon(Icons.admin_panel_settings_rounded))),
              ),
              const Text(
                'GOV-Complaint',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/chatbot');
                },
                child: Image.asset(
                  'assets/icons/icon_chatbot.png',
                ),
              )
            ],
          ),
        ),
      ),
      body: NewsScreen(),
      floatingActionButton: Material(
        elevation: 4,
        color: Colors.transparent,
        shadowColor: Color.fromARGB(255, 236, 123, 115),
        shape: CircleBorder(),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addcomplaint');
          },
          backgroundColor: Color.fromARGB(255, 236, 123, 115),
          child: Icon(Icons.add),
          // mini: true,
        ),
      ),
    );
  }
}
