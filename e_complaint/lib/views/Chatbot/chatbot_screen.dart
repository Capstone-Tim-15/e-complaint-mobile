import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  Color primaryColor = const Color(0xFFFFFFFF);
  Color secondaryColor = const Color(0xFF0073E6);
  Color bodyBg = const Color(0xFFE4E4E4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Iconify(
            Fa6Solid.arrow_left,
            color: secondaryColor,
            size: 20,
          ),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: secondaryColor,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: Iconify(
                    Fa6Solid.robot,
                    color: secondaryColor,
                    size: 15,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Text(
              'CS GOV',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: bodyBg,
      ),
    );
  }
}
