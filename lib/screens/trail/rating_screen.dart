import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/helpers/emoji_feedback.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/providers/request_provider.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key, required this.request}) : super(key: key);

  final RequestModel request;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int rating = 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: size.height * 0.15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const Text(
            'How was your experience?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Provide honest feedback per service delivery and any other factor. This will be used to help us serve you better.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: EmojiFeedback(
            availableWidth: size.width - 30,
            currentIndex: rating,
            onChange: (val) {
              setState(() {
                rating = val;
              });
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            onPressed: () async {
              await Provider.of<RequestProvider>(context, listen: false)
                  .sendRating(widget.request, rating, context);
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Thank you for your feedback!',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: kIconColor,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            textColor: Colors.white,
            color: kIconColor,
            child: const Text('Submit'),
          ),
        )
      ]),
    );
  }
}
