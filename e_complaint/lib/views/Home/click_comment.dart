import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.white)),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Postingan Berita',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman baru dengan dialog full screen
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => FullScreenCommentPage(),
              ),
            );
          },
          child: Icon(Icons.comment),
        ),
      ),
    );
  }
}

class FullScreenCommentPage extends StatefulWidget {
  @override
  _FullScreenCommentPageState createState() => _FullScreenCommentPageState();
}

class _FullScreenCommentPageState extends State<FullScreenCommentPage> {
  // FocusNode untuk mengatur fokus pada TextField
  final FocusNode _commentFocusNode = FocusNode();

  // TextEditingController untuk mengatur teks pada TextField
  final TextEditingController _commentController = TextEditingController();

  // Maksimum jumlah karakter yang diperbolehkan
  final int maxCharacterCount = 20000;

  @override
  void initState() {
    super.initState();
    // Setelah build selesai, fokus pada TextField dengan penundaan 300 milidetik
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_commentFocusNode);
    });

    // Listener untuk memperbarui teks pada TextField
    _commentController.addListener(updateCharacterCount);
  }

  // Fungsi untuk memperbarui jumlah karakter pada teks interaktif
  void updateCharacterCount() {
    setState(() {
      // Dapatkan panjang teks saat ini
      int currentCharacterCount = _commentController.text.length;
      // Update teks interaktif
      _characterCountText = '$currentCharacterCount/$maxCharacterCount';
    });
  }

  @override
  void dispose() {
    // Hapus FocusNode dan TextEditingController untuk mencegah memory leak
    _commentFocusNode.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // Teks interaktif yang akan diperbarui
  String _characterCountText = '0/20000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Atur warna ikon tombol "X" menjadi #666666
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Logika untuk menutup pop-up
            Navigator.of(context).pop();
          },
          color: Color(0xFF666666),
        ),
        actions: [
          // Pindahkan tombol "Reply" ke sebelah kanan
          TextButton(
            onPressed: () {
              // Logika untuk menyimpan komentar
              // Tambahkan kode sesuai kebutuhan
              Navigator.of(context).pop();
            },
            child: Text(
              'Reply',
              style: TextStyle(
                color: Color(0xFFE02216),
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
                    fontWeight:
                        FontWeight.normal, // Mengubah ketebalan menjadi normal
                    color: Color(0xFF999999), // Atur warna teks menjadi #999999
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Box TextField berwarna abu-abu
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _commentController,
                    focusNode: _commentFocusNode,
                    maxLines: 16,
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
                      _characterCountText, // Tampilkan teks interaktif
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
