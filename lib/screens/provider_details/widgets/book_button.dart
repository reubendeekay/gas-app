import 'package:flutter/material.dart';
import 'package:gas/constants.dart';
import 'package:gas/screens/check_out/check_out_screen.dart';

class BookButton extends StatelessWidget {
  const BookButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const transitionDuration = Duration(milliseconds: 200);

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: transitionDuration,
            reverseTransitionDuration: transitionDuration,
            pageBuilder: (_, animation, ___) {
              return FadeTransition(
                opacity: animation,
                child: const CheckoutScreen(),
              );
            },
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
