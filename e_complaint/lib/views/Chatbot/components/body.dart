import 'package:e_complaint/models/chat_message.dart';
import 'package:e_complaint/viewModels/services/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatbotBody extends StatefulWidget {
  const ChatbotBody({Key? key}) : super(key: key);

  @override
  State<ChatbotBody> createState() => _ChatbotBodyState();
}

class _ChatbotBodyState extends State<ChatbotBody> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  dynamic result;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatMessage.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                clipper: ChatBubbleClipper1(
                  type: chatMessage[index].isSender
                      ? BubbleType.sendBubble
                      : BubbleType.receiverBubble,
                ),
                child: Text(chatMessage[index].text),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Send a message',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              chatMessage.add(ChatMessage(text: _controller.text, isSender: true));
              _getRecommendation();
            });
          },
          child: Text('Send'),
        ),
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
