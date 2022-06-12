import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                fillColor: Colors.grey[300],
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                prefixIcon: const Icon(Icons.search))),
      ),
    );
  }
}
