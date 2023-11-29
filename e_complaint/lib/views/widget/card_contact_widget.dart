import 'package:flutter/material.dart';
import 'package:flutter_profil_page/src/models/user_profile.dart';

class Card_Contact extends StatelessWidget {
  const Card_Contact({
    super.key,
    required this.user,
  });

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: 206,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 18,
              ),
              Center(
                child: Text(
                  'Jelita Salsabila',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Container(
                  color: Colors.black,
                  height: 1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildInfoRow('Email', user.email),
              SizedBox(
                height: 10,
              ),
              buildInfoRow('Telephone', user.phoneNumber),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text("Halo"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, right: 45, left: 45),
                child: Container(
                  color: Colors.deepOrangeAccent,
                  height: 2,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat detail profil",
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '$label',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
