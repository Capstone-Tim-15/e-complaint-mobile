import 'package:flutter/material.dart';

class ResultBerita extends StatefulWidget {
  const ResultBerita({super.key});

  @override
  State<ResultBerita> createState() => _ResultBeritaState();
}

class _ResultBeritaState extends State<ResultBerita> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Berita'),
      ),
    );
  }
}
