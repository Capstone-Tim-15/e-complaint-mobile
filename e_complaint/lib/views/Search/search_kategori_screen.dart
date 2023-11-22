import 'package:e_complaint/views/Search/widget/kategori_button.dart';
import 'package:e_complaint/views/Search/widget/search_field.dart';

import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> newsItems = [
    {
      'image': 'assets/images/news1.png',
      'source': 'Source: BBC News',
      'title':
          'LBP Resmikan Pabrik Daur Ulang Sampah Plastik jadi Coffe Maker di Batam',
    },
    {
      'image': 'assets/images/news2.png',
      'source': 'Source: suarabatam.id',
      'title': 'Gangguan Pipa, Ini Wilayah Terdampak Mati Air di Batam Hari Ini',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: SearchField(controller: _searchController)),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    text: 'Kekerasan',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Bullying',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Sampah',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    text: 'Pungli',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Infrastruktur',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Umum',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomElevatedButton(
                    text: 'Pelayanan',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Keamanan',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                  CustomElevatedButton(
                    text: 'Pelecehan',
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Berita Terkini',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(width: 1, color: Colors.black12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Image.asset(
                              newsItems[index]['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                newsItems[index]['source'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                newsItems[index]['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
