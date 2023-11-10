//rani

import 'package:flutter/material.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          //tombol kembali
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),

          // nama
          title: Text('Buat Keluhan'),
          centerTitle: true,
          backgroundColor: Colors.white,

          // tombol keluar
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        body: Container(
          child: Column(
            children: [
              // profil pengguna

              // kolom keluhan

              // preview gambar keluhan

              // crud gambar

              //dropdown kategori

              //tompol posting
            ],
          ),
        ),
      ),
    );
  }
}
