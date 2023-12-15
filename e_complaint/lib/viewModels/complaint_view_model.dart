import 'package:e_complaint/models/complaint.dart';
import 'package:e_complaint/viewModels/provider/complaint.dart';
import 'package:flutter/material.dart';

enum ComplaintStatus {
  SEND,
  Diproses,
  Selesai,
}

class ComplaintsViewModel extends ChangeNotifier {
  final AddComplaintProvider addComplaintProvider;

  ComplaintsViewModel({required this.addComplaintProvider});

  List<Complaint> get complaintList => addComplaintProvider.complaintList;

  List<Complaint> getComplaintsByStatus(ComplaintStatus status) {
    return complaintList.where((complaint) {
      return complaint.status.toLowerCase() == getStatusString(status);
    }).toList();
  }

  String getStatusString(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.SEND:
        return 'SEND';
      case ComplaintStatus.Diproses:
        return 'Diproses';
      case ComplaintStatus.Selesai:
        return 'Selesai';
    }
  }

  void updateSelectedLocation(String location) {
    addComplaintProvider.updateSelectedLocation(location);
    notifyListeners();
  }

  Future<void> getComplaint() async {
    await addComplaintProvider.getComplaint();
    notifyListeners();
  }
}
