import 'package:e_complaint/views/Search/result/result_berita_page.dart';
import 'package:e_complaint/views/Search/result/result_keluhan_page.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';

class ResultPage extends StatefulWidget {
  final String idCategory;
  final bool news;

  const ResultPage({Key? key, required this.idCategory, required this.news})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final TextEditingController _searchController = TextEditingController();
  int _navIndex = 0; // This is just an example. Set your initial index here.
  List<String> searchHistory = ['History 1', 'History 2', 'History 3'];
  bool _isVisible = false;
  bool _isIndexedVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.news == true) {
      setState(() {
        _navIndex = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const ResultPage()),
                            // );
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
                        padding: const EdgeInsets.only(left: 50.0, top: 33),
                        child: Container(
                          width: 360,
                          height: 190,
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
                  Indexed(
                    index: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['Keluhan', 'Berita'].map((label) {
                          int index = ['Keluhan', 'Berita'].indexOf(label);
                          return TextButton(
                            child: Text(
                              label,
                              style: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              setState(() {
                                _navIndex = index;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Indexed(
                    index: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 2,
                            color: _navIndex == 0 ? Colors.red : Colors.transparent,
                          ),
                          Container(
                            width: 100,
                            height: 2,
                            color: _navIndex == 1 ? Colors.red : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Indexed(
                    index: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.777,
                        child: IndexedStack(
                          index: _navIndex,
                          children: <Widget>[
                            ResultKeluhan(idCategory: widget.idCategory),
                            ResultBerita(idCategory: widget.idCategory),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
