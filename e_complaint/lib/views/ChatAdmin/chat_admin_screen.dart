import 'package:e_complaint/views/ChatAdmin/components/chat_admin_body.dart';
import 'package:e_complaint/views/Chatbot/components/constants.dart';
import 'package:flutter/material.dart';

class ChatAdminScreen extends StatefulWidget {
  const ChatAdminScreen({super.key});

  @override
  State<ChatAdminScreen> createState() => _ChatAdminScreenState();
}

class _ChatAdminScreenState extends State<ChatAdminScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const ChatAdminBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kAppbarbg,
      title: Row(
        children: [
          const BackButton(
            color: kPrimaryColor,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.admin_panel_settings_rounded)),
            ),
          ),
          const Text(
            'Admin-Yadi',
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
