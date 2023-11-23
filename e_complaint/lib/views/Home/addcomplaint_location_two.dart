import 'package:flutter/material.dart';

class LocationTwo extends StatefulWidget {
  const LocationTwo({super.key});

  @override
  State<LocationTwo> createState() => _LocationTwoState();
}

class _LocationTwoState extends State<LocationTwo> {
  // Daftar kecamatan
  final List<String> jalanList = [
    'Jalan Amir Hamzah',
    'Jalan Bawal',
    'Jalan Duyung',
    'Jalan Engku Putri',
    'Jalan Imam Bonjol',
    'Jalan Ahmad Yani',
    'Jalan Letjen Suprapto',
    'Jalan MT Haryono',
    'Jalan Raja Haji Fisabilillah',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 77, 77),
        title: Text('Tambah Lokasi'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 18,
          fontStyle: FontStyle.normal,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Menetapkan alignment ke start (kiri)
          children: [
            Text(
              'Lokasi Terpilih',
              style: TextStyle(
                color: Color.fromARGB(255, 240, 77, 77),
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/image/loc.png',
                  width: 50,
                  height: 40,
                  alignment: Alignment.center,
                ),
                Text(
                  'Batam Kota',
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 15,bottom: 15, left: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: Color.fromARGB(255, 240, 77, 77), // warna border
                  width: 1.0, // ketebalan border
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.radio_button_on_rounded, color: Color.fromARGB(255, 240, 77, 77),),
                  ),
                  Expanded(
                    child: Text(
                      'Pilih Jalan',
                      style: TextStyle(
                        fontSize: 16.0, // Sesuaikan ukuran font jika perlu
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Jalan',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: jalanList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          '${jalanList[index]}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Aksi yang diambil ketika ListTile ditekan
                          print('Anda memilih kecamatan: ${jalanList[index]}');
                        },
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
