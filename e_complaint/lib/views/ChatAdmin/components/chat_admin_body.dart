import 'package:e_complaint/views/Chatbot/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint/models/chat_admin_message.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatAdminBody extends StatefulWidget {
  const ChatAdminBody({super.key});

  @override
  State<ChatAdminBody> createState() => _ChatAdminBodyState();
}

class _ChatAdminBodyState extends State<ChatAdminBody> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  dynamic result;

  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://34.128.69.15:8000/chat/user/ws/join-room/:AhI8EP'),
  );

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMM dd, hh.mm a').format(now);

    return Column(
      children: [
        Expanded(
          child: Container(
            color: kBodyBg,
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Center(
                  child: Text(formattedDate),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatAdminMessage.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: chatAdminMessage[index].isUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (!chatAdminMessage[index].isUser)
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
                                      scale: 1.5,
                                      child: const Icon(
                                          Icons.admin_panel_settings_rounded)),
                                ),
                              Expanded(
                                child: ChatBubble(
                                  backGroundColor: chatAdminMessage[index].isUser
                                      ? kPrimaryColor
                                      : Colors.white,
                                  alignment: chatAdminMessage[index].isUser
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  clipper: ChatBubbleClipper1(
                                    type: chatAdminMessage[index].isUser
                                        ? BubbleType.sendBubble
                                        : BubbleType.receiverBubble,
                                  ),
                                  child: Text(
                                    chatAdminMessage[index].text,
                                    style: TextStyle(
                                      color: chatAdminMessage[index].isUser
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              if (chatAdminMessage[index].isUser)
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
                    }),
              ],
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
                  onPressed: _sendMessage,
                  // onPressed: () {
                  //   setState(() {
                  //     chatAdminMessage.add(
                  //         ChatAdminMessage(text: _controller.text, isUser: true));
                  //     // Logic
                  //     _controller.clear();
                  //   });
                  // },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
