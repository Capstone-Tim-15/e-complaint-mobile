import 'package:e_complaint/models/chat_message.dart';
import 'package:e_complaint/viewModels/services/chatbot.dart';
import 'package:e_complaint/views/Chatbot/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class ChatbotBody extends StatefulWidget {
  const ChatbotBody({Key? key}) : super(key: key);

  @override
  State<ChatbotBody> createState() => _ChatbotBodyState();
}

class _ChatbotBodyState extends State<ChatbotBody> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  dynamic result;

  List<String> recommendedQuestions = [
    'Bagaimana cara mengajukan pengaduan?',
    'Bagaimana melacak status pengaduan saya?',
    'Apa saja kategori pengaduan yang tersedia?',
    'Chat dengan CS GOV Complaints',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: kBodyBg,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: chatMessage.length + recommendedQuestions.length,
              itemBuilder: (context, index) {
                if (index < recommendedQuestions.length) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.text = recommendedQuestions[index];
                          },
                          child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  recommendedQuestions[index],
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Item di bawah
                  final chatIndex = index - recommendedQuestions.length;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: chatMessage[chatIndex].isSender
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!chatMessage[chatIndex].isSender)
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                              ),
                              child: Transform.scale(
                                scale: 0.7,
                                child: const Iconify(
                                  kchatBotIcon,
                                  color: kPrimaryColor,
                                  size: 8,
                                ),
                              ),
                            ),
                          Expanded(
                            child: ChatBubble(
                              backGroundColor: chatMessage[chatIndex].isSender
                                  ? kPrimaryColor
                                  : Colors.white,
                              alignment: chatMessage[chatIndex].isSender
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              clipper: ChatBubbleClipper1(
                                type: chatMessage[chatIndex].isSender
                                    ? BubbleType.sendBubble
                                    : BubbleType.receiverBubble,
                              ),
                              child: Text(
                                chatMessage[chatIndex].text,
                                style: TextStyle(
                                  color: chatMessage[chatIndex].isSender
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          if (chatMessage[chatIndex].isSender)
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 25,
                                color: kPrimaryColor,
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Iconify(
                    Mdi.send,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      chatMessage
                          .add(ChatMessage(text: _controller.text, isSender: true));
                      _getRecommendation();
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _getRecommendation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await ChatbotService.getAnswer(
        question: _controller.value.text,
      );
      setState(() {
        chatMessage.add(ChatMessage(text: result.choices[0].text, isSender: false));
        isLoading = false;
      });
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Failed to send a request'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
