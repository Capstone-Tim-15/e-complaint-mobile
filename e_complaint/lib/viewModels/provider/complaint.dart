import 'package:flutter/material.dart';

class AddComplaintProvider extends ChangeNotifier {
  String _selectedLocation = 'Tambahkan Alamat';
  String get selectedLocation => _selectedLocation;

  void updateSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }
}
