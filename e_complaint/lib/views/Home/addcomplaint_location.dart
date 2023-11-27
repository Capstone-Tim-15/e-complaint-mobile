import 'package:e_complaint/viewModels/provider/complaint.dart';
import 'package:e_complaint/views/Home/home_addcomplaint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintLocation extends StatefulWidget {
  const ComplaintLocation({super.key});

  @override
  State<ComplaintLocation> createState() => _ComplaintLocationState();
}

class _ComplaintLocationState extends State<ComplaintLocation> {
  final List<String> kecamatanList = [
    'Batam Kota',
    'Bengkong',
    'Bulang',
    'Galang',
    'Lubuk Baja',
    'Nongsa',
    'Sagulung',
    'Sei',
    'Sekupang',
  ];

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
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddComplaint(
                          selectedLocation: '',
                          selectedLocation2: '',
                        )), // Ganti HalamanTujuan dengan halaman yang diinginkan
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kecamatan',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: kecamatanList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('${kecamatanList[index]}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UtamaLocation(
                                  selectedLocation: kecamatanList[index]),
                            ),
                          );
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

class UtamaLocation extends StatefulWidget {
  final String selectedLocation;

  const UtamaLocation({super.key, required this.selectedLocation});

  @override
  State<UtamaLocation> createState() => _UtamaLocationState();
}

class _UtamaLocationState extends State<UtamaLocation> {
  bool isJalanSelected = false;

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
    final complaintProvider = Provider.of<AddComplaintProvider>(context);
    print(complaintProvider.selectedLocation);
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  widget.selectedLocation,
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: Color.fromARGB(255, 240, 77, 77),
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.radio_button_on_rounded),
                  ),
                  Expanded(
                    child: Text(
                      'Pilih Jalan',
                      style: TextStyle(
                        fontSize: 16.0,
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
                          print(
                              'Nilai yang dipilih: ${widget.selectedLocation}');
                          print('Nilai yang dipilih: ${jalanList[index]}');
                          String locationSelected = '${widget.selectedLocation} , ${jalanList[index]}';
                          complaintProvider.updateSelectedLocation(locationSelected);
                          setState(() {
                            isJalanSelected = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddComplaint(
                                selectedLocation: '',
                                selectedLocation2: '',
                              ),
                            ),
                          );
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

void main() {
  runApp(MaterialApp(
    home: ComplaintLocation(),
  ));
}
