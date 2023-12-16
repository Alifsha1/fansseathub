// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message ?? '',
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "ok",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

class Heading extends StatelessWidget {
  const Heading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FansSeatHub',
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: "Miltonian_Tattoo",
          color: Colors.black),
    );
  }
}

class HeadingWhite extends StatelessWidget {
  const HeadingWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FansSeatHub',
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: "Miltonian_Tattoo",
          color: Colors.white),
    );
  }
}


class ButtonElevated extends StatelessWidget {
  final String buttonText;
  const ButtonElevated({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ));
  }
}

class AdminSideHeadings extends StatelessWidget {
  final String headings;
  const AdminSideHeadings({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AdminSideHeadingsBlack extends StatelessWidget {
  final String headings;
  const AdminSideHeadingsBlack({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AdminTextField extends StatelessWidget {
  final String errormessage;
  final String? Function(String?)? validator;
  final String hinttext;
  final TextEditingController controller;
  const AdminTextField(
      {super.key,
      required this.hinttext,
      this.validator,
      required this.controller,
      required this.errormessage});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: hinttext,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return errormessage;
        }
      },
    );
  }
}

