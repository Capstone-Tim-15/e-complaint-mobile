import 'package:flutter/material.dart';

class faq extends StatelessWidget {
  const faq({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
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
        child: ListTile(
          leading: Icon(Icons.headset_mic_outlined, color: Colors.black),
          title: Text(
            'FAQ',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
          onTap: () {
            Navigator.pushNamed(context, '/faq_page');
          },
        ),
      ),
    );
  }
}
