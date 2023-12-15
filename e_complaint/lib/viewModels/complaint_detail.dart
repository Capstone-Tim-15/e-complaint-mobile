// Import necessary packages and libraries
import 'package:e_complaint/models/complaint_detail.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the ViewModel class
class ComplaintViewModel extends ChangeNotifier {
  Dio _dio = Dio();
  String baseUrl = "https://api.govcomplain.my.id";
  late ComplaintModel complaintData;

  Future<void> getComplaintById(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearerToken');

      // Set header bearer token
      _dio.options.headers['Authorization'] = 'Bearer $token';

      Response response =
          await _dio.get('$baseUrl/user/complaint/search?id=$id');

      if (response.statusCode == 200) {
        final responseData = response.data['results'];
        complaintData = ComplaintModel(
          id: responseData['id'],
          userId: responseData['userId'],
          name: responseData['name'],
          photoImage: responseData['photoImage'],
          category: responseData['category'],
          title: responseData['title'],
          content: responseData['content'],
          address: responseData['address'],
          status: responseData['status'],
          imageUrl: responseData['imageUrl'],
          createdAt: responseData['createdAt'],
          updateAt: responseData['updateAt'],
          comment: List<Map<String, dynamic>>.from(responseData['comment']),
        );
        print("Complaint Data: $complaintData");
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
      // Handle error gracefully, e.g., show an error message to the user.
    }
  }
}
