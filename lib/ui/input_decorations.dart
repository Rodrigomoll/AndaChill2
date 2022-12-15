import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 209, 82, 82)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 187, 71, 71), width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(Icons.alternate_email_sharp,
                color: Color.fromARGB(255, 187, 73, 73))
            : null);
  }
}
