import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  Color kPrimaryColor = const Color(0xFF0073E6);
  Color kAppbarbg = const Color(0xFFFFFFFF);
  Color kBodyBg = const Color(0xFFE4E4E4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: kBodyBg,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kAppbarbg,
      title: Row(
        children: [
          BackButton(
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
                icon: Iconify(
                  Fa6Solid.robot,
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
