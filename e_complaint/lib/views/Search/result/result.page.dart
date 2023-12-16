import 'package:e_complaint/views/Search/result/result_berita_page.dart';
import 'package:e_complaint/views/Search/result/result_keluhan_page.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Clear History Search
  Future<void> deleteValue(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? savedValues = preferences.getStringList('values');
    if (savedValues != null && savedValues.length > index) {
      savedValues.removeAt(index);
      await preferences.setStringList('values', savedValues);
      // You might want to update the UI after deletion
      setState(() {});
    }
  }

  // Add History Search
  Future<void> saveValue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedValues = prefs.getStringList('values');
    savedValues ??= [];
    savedValues.add(value);
    await prefs.setStringList('values', savedValues);
  }

  // Get History Search
  Future<List<String>> getValues() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? values = prefs.getStringList('values');
    values ??= [];
    return values;
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
                          onSubmitted: (value) async {
                            await saveValue(value);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                        idCategory: value,
                                        news: true,
                                      )),
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
                  FutureBuilder<List<String>>(
                    future: getValues(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                          // Reverse the order of the list to display the most recent data at the top
                          List<String> reversedValues =
                              snapshot.data!.reversed.toList();

                          return Visibility(
                            visible: _isVisible,
                            child: Indexed(
                              index: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 34.0),
                                child: Center(
                                  child: Container(
                                    width: 360,
                                    height: 180,
                                    padding:
                                        const EdgeInsets.only(left: 8.0, right: 8),
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
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: reversedValues.length > 3
                                              ? 3
                                              : reversedValues.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(reversedValues[index]),
                                                  InkWell(
                                                    child: const Text(
                                                      'Hapus',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onTap: () async {
                                                      await deleteValue(index);
                                                      setState(() {
                                                        _isVisible = !_isVisible;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                // Implement tap logic here
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Jika data tidak ada, tidak tampilkan widget
                          return Container();
                        }
                      }
                    },
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
