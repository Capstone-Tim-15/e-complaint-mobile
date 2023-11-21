import 'package:flutter/material.dart';

class ComplaintLocation extends StatefulWidget {
  const ComplaintLocation({super.key});

  @override
  State<ComplaintLocation> createState() => _ComplaintLocationState();
}

class _ComplaintLocationState extends State<ComplaintLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tambah Lokasi'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontStyle: FontStyle.normal,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 239, 83, 72),
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Text('Kecamatan'),
            Divider(
              thickness: 2.0,
            ),
            ListTile(
              title: Text('Batam Kota'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Bengkong'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Bulang'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Galang'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Lubuk Baja'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Nongsa'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sagulung'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sei'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
            ListTile(
              title: Text('Sekupang'),
              onTap: () {
                // Aksi yang diambil ketika ListTile ditekan
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}