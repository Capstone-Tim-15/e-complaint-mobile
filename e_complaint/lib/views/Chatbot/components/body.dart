import 'package:e_complaint/models/chat_message.dart';
import 'package:e_complaint/viewModels/services/chatbot.dart';
import 'package:e_complaint/views/Chatbot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatbotBody extends StatefulWidget {
  const ChatbotBody({Key? key}) : super(key: key);

  @override
  State<ChatbotBody> createState() => _ChatbotBodyState();
}

class _ChatbotBodyState extends State<ChatbotBody> {
  final TextEditingController question = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  dynamic result;
  late SharedPreferences prefs;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    _scrollController.dispose();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      imageUrl = prefs.getString('imageUrl') ?? '';
    });
  }

  List<String> recommendedQuestions = [
    'Bagaimana cara mengajukan pengaduan?',
    'Bagaimana melacak status pengaduan saya?',
    'Apa saja kategori pengaduan yang tersedia?',
    'Chat dengan CS GOV Complaints',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: kBodyBg,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: chatbotMessage.length + recommendedQuestions.length,
                itemBuilder: (context, index) {
                  if (index < recommendedQuestions.length) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 60.0, right: 60),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              question.text = recommendedQuestions[index];
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
                          mainAxisAlignment: chatbotMessage[chatIndex].isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!chatbotMessage[chatIndex].isSender)
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
                                backGroundColor: chatbotMessage[chatIndex].isSender
                                    ? kPrimaryColor
                                    : Colors.white,
                                alignment: chatbotMessage[chatIndex].isSender
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                clipper: ChatBubbleClipper1(
                                  type: chatbotMessage[chatIndex].isSender
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble,
                                ),
                                child: Text(
                                  chatbotMessage[chatIndex].text,
                                  style: TextStyle(
                                    color: chatbotMessage[chatIndex].isSender
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            if (chatbotMessage[chatIndex].isSender)
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
                                  child: imageUrl == ''
                                      ? const Icon(
                                          Icons.person,
                                          size: 25,
                                          color: kPrimaryColor,
                                        )
                                      : Image.network(imageUrl)),
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
                      controller: question,
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
                        chatbotMessage.add(
                            ChatBotMessage(text: question.text, isSender: true));
                        _getRecommendation();
                        print('Question: ${question.value.text}');
                        question.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _getRecommendation() async {
    setState(() {
      isLoading = true;
    });

    String jwtToken = prefs.getString('bearerToken') ?? '';

    // Create a variable to store the instance of the provider
    var chatbotService = Provider.of<ChatbotServiceProvider>(context, listen: false);

    try {
      await chatbotService.getRecommendation(
          question: question.value.text, jwt: jwtToken);

      // print('JWT Token: $jwtToken');

      setState(() {
        chatbotMessage.add(ChatBotMessage(
            text: chatbotService.aiData.results.recommendation, isSender: false));
        isLoading = false;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      print('Exception: $e');
      // print('JWT Token: $jwtToken');
      const snackBar = SnackBar(
        content: Text('Failed to send a request'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
