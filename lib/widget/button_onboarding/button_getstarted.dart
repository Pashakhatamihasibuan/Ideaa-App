import 'package:final_project/component/color.dart';
import 'package:final_project/pages/login/login.dart';
import 'package:flutter/material.dart';

Widget getStarted(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: primaryColor,
    ),
    width: MediaQuery.of(context).size.width * .9,
    height: 55,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      child: const Text(
        "Get Started",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}
