import 'package:e_complaint/viewModels/provider/news_search_provider.dart';
import 'package:e_complaint/views/Search/result/result.page.dart';
import 'package:e_complaint/views/Search/widget/kategori_button.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final NewsSearchProvider newsProf;
  final TextEditingController _searchController = TextEditingController();
  String jwt = '';
  bool _isVisible = false;
  // ignore: unused_field
  bool _isIndexedVisible = true;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jwt = prefs.getString('token') ?? '';
    });

    newsProf.fetchData(jwt);
  }

  List<String> searchHistory = ['History 1', 'History 2', 'History 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indexer(
                children: [
                  Indexed(
                    index: 0,
                    child: Center(
                        child: Container(
                      width: 360,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFFE02216),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onTap: () {
                            setState(() {
                              _isVisible = true;
                            });
                          },
                          onSubmitted: (value) {
                            searchHistory.add(value);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResultPage()),
                            );
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Cari keluhan atau berita",
                            suffixIcon: InkWell(
                              onTap: () {
                                _searchController.clear();
                                setState(() {
                                  _isVisible = false;
                                  _isIndexedVisible = false;
                                });
                              },
                              child: const Icon(Icons.cancel),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                        ),
                      ),
                    )),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: Indexed(
                      index: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 34.0),
                        child: Center(
                          child: Container(
                            width: 360,
                            height: 180,
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(color: Colors.red),
                                left: BorderSide(color: Colors.red),
                                right: BorderSide(color: Colors.red),
                              ),
                            ),
                            child: Column(
                              children: [
                                const Divider(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: searchHistory.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(searchHistory[index]),
                                          InkWell(
                                            child: const Text(
                                              'Hapus',
                                              style: TextStyle(color: Colors.red),
                                            ),
                                            onTap: () {},
                                          )
                                        ],
                                      ),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Indexed(
                    index: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                        ],
                      ),
                    ),
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
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: newsItems.length,
              //   itemBuilder: (context, index) {
              //     return InkWell(
              //       onTap: () {},
              //       child: Card(
              //         margin: const EdgeInsets.all(20),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //           side: const BorderSide(width: 1, color: Colors.black12),
              //         ),
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: <Widget>[
              //             Flexible(
              //               child: Image.asset(
              //                 newsItems[index]['image'],
              //                 fit: BoxFit.cover,
              //                 width: double.infinity,
              //                 height: 200,
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: Text(
              //                   newsItems[index]['source'],
              //                   style: const TextStyle(
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w300,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              //               child: Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: Text(
              //                   newsItems[index]['title'],
              //                   style: const TextStyle(
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                   textAlign: TextAlign.left,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
