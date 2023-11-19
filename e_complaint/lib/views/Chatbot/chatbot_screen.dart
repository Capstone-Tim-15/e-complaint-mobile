
import 'package:e_complaint/views/Chatbot/components/body.dart';
import 'package:e_complaint/views/Chatbot/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const ChatbotBody(),
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
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2,
                ),
              ),
              child: IconButton(
                icon: const Iconify(
                  kchatBotIcon,
                  color: kPrimaryColor,
                  size: 15,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Text(
            'CS GOV',
            style: TextStyle(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}

