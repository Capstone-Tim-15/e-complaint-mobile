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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SearchField(controller: _searchController),
            ),
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
          ],
        ),
      ),
    );
  }
}
