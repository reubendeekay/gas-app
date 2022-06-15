import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({Key? key, this.onChanged, required this.title})
      : super(key: key);

  final String title;
  final Function(String val)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {
        if (onChanged != null) {
          onChanged!(val);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        labelText: title,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }
}
