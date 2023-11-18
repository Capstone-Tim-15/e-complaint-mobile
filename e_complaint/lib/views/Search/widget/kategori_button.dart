import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // background color
        foregroundColor: Colors.black, // text color
        side: const BorderSide(color: Colors.red), // border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // rounded corners
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    );
  }
}
