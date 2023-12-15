import 'package:dio/dio.dart';
import 'package:e_complaint/models/complaint.dart';
import 'package:flutter/material.dart';

class AddComplaintProvider extends ChangeNotifier {
  String _selectedLocation = 'Tambahkan Alamat';
  String get selectedLocation => _selectedLocation;

  final String bearerToken;

  AddComplaintProvider({required this.bearerToken});

  List<Complaint> _complaintList = [];

  List<Complaint> get complaintList => _complaintList;

  void updateSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }

  Future<void> getComplaint() async {
    if (bearerToken.isEmpty) {
      print('bearerToken.isEmpty');
      return;
    }

    try {
      final response = await Dio().get(
          'https://api.govcomplain.my.id/user/complaint?page=6',
          options: Options(headers: {'Authorization': 'Bearer $bearerToken'}));

      final List<dynamic> data = response.data['results'];
      _complaintList = data
          .map(
            (e) => Complaint(
              id: e['id'],
              userId: e['userId'],
              name: e['name'],
              photoImage: e['photoImage'],
              category: e['category'],
              title: e['title'],
              content: e['content'],
              status: e['status'],
              imageUrl: e['imageUrl'],
              comment: e['comment'] ?? '',
            ),
          )
          .toList();
      print('$_complaintList');
      notifyListeners();
    } catch (e) {
      print('error fetching complaint');
    }
  }
}
