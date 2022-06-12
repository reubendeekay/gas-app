import 'package:flutter/material.dart';
import 'package:gas/screens/search/widgets/search_text_field.dart';

class SearchOverviewScreen extends StatelessWidget {
  const SearchOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SearchTextField(),
        ],
      ),
    );
  }
}
