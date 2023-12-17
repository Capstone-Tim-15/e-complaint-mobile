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
  late final NewsSearchProvider newsSearchProv;
  final TextEditingController _searchController = TextEditingController();
  String idCategory = '';
  bool _isVisible = false;
  // ignore: unused_field
  bool _isIndexedVisible = true;

  @override
  void initState() {
    super.initState();
    newsSearchProv = context.read<NewsSearchProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsSearchProv.fetchData();
    });
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
      'title':
          'Gangguan Pipa, Ini Wilayah Terdampak Mati Air di Batam Hari Ini',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final newsSearchProv = Provider.of<NewsSearchProvider>(context);
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
                      height: 50,
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
                                  setState(() {
                                    idCategory = '3DPTz6';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Bullying',
                                onPressed: () {
                                  setState(() {
                                    idCategory = 'lMJm4r';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Sampah',
                                onPressed: () {
                                  setState(() {
                                    idCategory = 'DA7CZu';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
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
                                  setState(() {
                                    idCategory = 'I2fnXf';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Infrastruktur',
                                onPressed: () {
                                  setState(() {
                                    idCategory = '1bKOCe';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Umum',
                                onPressed: () {
                                  setState(() {
                                    idCategory = 'ySJruI';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
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
                                  setState(() {
                                    idCategory = 'AstfNS';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Keamanan',
                                onPressed: () {
                                  setState(() {
                                    idCategory = 'jQBmPE';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
                                },
                              ),
                              CustomElevatedButton(
                                text: 'Pelecehan',
                                onPressed: () {
                                  setState(() {
                                    idCategory = 'gcKUBm';
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                              idCategory: idCategory,
                                              news: false,
                                            )),
                                  );
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

              newsSearchProv.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final news = newsSearchProv.newsSearchData[index];
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            margin: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side:
                                  const BorderSide(width: 1, color: Colors.black12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (news.imageUrl != "")
                                  Flexible(
                                    child: Image.network(
                                      'https://res.cloudinary.com/dua3iphs9/image/upload/v1700572036/${news.imageUrl}',
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
                                      news.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, bottom: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      news.title,
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
