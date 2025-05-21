import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static go(
      {required BuildContext context,
      required dynamic screen,
      bool replace = false}) {
    replace
        ? Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => screen,
            ))
        : Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => screen,
            ),
          );
  }
}

showLoading(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: CupertinoActivityIndicator(
                color: Colors.black,
                radius: 23,
              ),
            ),
          ),
        ),
      );
    },
  );
}
