import 'package:e_complaint/viewModels/provider/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullScreenCommentPage extends StatefulWidget {
  final String id;
  final void Function() onReplyComplete;
  final void Function() onRefresh;

  FullScreenCommentPage({
    required this.id,
    required this.onReplyComplete,
    required this.onRefresh,
  });

  @override
  _FullScreenCommentPageState createState() => _FullScreenCommentPageState();
}

class _FullScreenCommentPageState extends State<FullScreenCommentPage> {
  NewsProvider _newsProvider = NewsProvider(bearerToken: 'bearerToken');

  final FocusNode _commentFocusNode = FocusNode();

  final TextEditingController _commentController = TextEditingController();

  final int maxCharacterCount = 20000;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_commentFocusNode);
    });

    _commentController.addListener(updateCharacterCount);
  }

  void updateCharacterCount() {
    setState(() {
      int currentCharacterCount = _commentController.text.length;
      _characterCountText = '$currentCharacterCount/$maxCharacterCount';
    });
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    _commentController.dispose();
    super.dispose();
  }

  String _characterCountText = '0/20000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Color(0xFF666666),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onReplyPressed(_commentController.text);
              print('Comment Content: ${_commentController.text}');
            },
            child: Text(
              'Reply',
              style: TextStyle(
                color: Color(0xFFE02216),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 8),
                Text(
                  'Menjawab Berita Admin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF9D3D0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    maxLines: 10,
                    style: TextStyle(color: Color(0xFFE64E45)),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Masukkan komentar Anda...',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _characterCountText,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onReplyPressed(String commentContent) async {
    try {
      String newsId = widget.id;

      if (commentContent.isNotEmpty) {
        var feedback =
            await _newsProvider.createFeedback(newsId, commentContent);
        if (feedback != null) {
          print('Feedback created successfully: $feedback');
          widget.onReplyComplete();
          widget.onRefresh();
          Navigator.of(context).pop();
        } else {
          print('Failed to create feedback: feedback is null');
        }
      } else {
        print('Comment content is empty or userId is null');
      }
    } catch (error) {
      print('Error during create feedback: $error');
    }
  }
}
