import 'package:e_complaint/views/Login/login_screen.dart';
import 'package:flutter/material.dart';

class keluar extends StatelessWidget {
  const keluar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEC7B73),
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
        child: ListTile(
          title: Center(
            child: Text(
              'Keluar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );
  }
}
