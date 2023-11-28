import 'package:flutter/material.dart';

class FullScreenCommentPage extends StatefulWidget {
  @override
  _FullScreenCommentPageState createState() => _FullScreenCommentPageState();
}

class _FullScreenCommentPageState extends State<FullScreenCommentPage> {
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
              Navigator.of(context).pop();
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
}
