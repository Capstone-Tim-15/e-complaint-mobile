import 'package:flutter/material.dart';

class Profiledetail extends StatefulWidget {
  const Profiledetail({super.key});

  @override
  State<Profiledetail> createState() => _ProfiledetailState();
}

class _ProfiledetailState extends State<Profiledetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Detail'),
      ),
      body: const Center(
        child: Text('Profile Detail'),
      ),
    );
  }
}