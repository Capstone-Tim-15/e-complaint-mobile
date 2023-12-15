import 'package:e_complaint/models/user_profile.dart';
import 'package:flutter/material.dart';

class CardContact extends StatelessWidget {
  const CardContact({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
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
            const SizedBox(
              height: 18,
            ),
            Center(
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Container(
                color: Colors.black,
                height: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildInfoRow('Email', user.email),
            const SizedBox(
              height: 10,
            ),
            buildInfoRow('Telephone', user.phoneNumber),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text("Halo"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 45, left: 45),
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                height: 2,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile-detail');
                },
                child: const Text(
                  "Lihat detail profil",
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
