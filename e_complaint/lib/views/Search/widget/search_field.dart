import 'package:e_complaint/views/Search/result/result.page.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;

  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFE02216),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResultPage()),
            );
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Cari keluhan atau berita",
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          ),
        ),
      ),
    );
  }
}
