import 'package:e_complaint/views/Search/result/result_berita_page.dart';
import 'package:e_complaint/views/Search/result/result_keluhan_page.dart';
import 'package:e_complaint/views/Search/widget/search_field.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final TextEditingController _searchController = TextEditingController();
  int _navIndex = 0; // This is just an example. Set your initial index here.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Center(child: SearchField(controller: _searchController)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['Berita', 'Keluhan'].map((label) {
                    int index = ['Berita', 'Keluhan'].indexOf(label);
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
                Row(
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
                Expanded(
                  child: IndexedStack(
                    index: _navIndex,
                    children: const <Widget>[
                      ResultBerita(),
                      ResultKeluhan(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
