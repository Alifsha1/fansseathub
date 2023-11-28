import 'package:flutter/material.dart';

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

class highlightsList extends StatelessWidget {
  const highlightsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 204, 197, 197)),
    );
  }
}

class ButtonElevated extends StatelessWidget {
  const ButtonElevated({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: Text(
            '+Add new video',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )),
    );
  }
}

class GameaddingField extends StatelessWidget {
  const GameaddingField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}
