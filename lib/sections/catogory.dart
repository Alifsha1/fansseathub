import 'package:flutter/material.dart';

class Catogory extends StatelessWidget {
  final String displayImage;
  final String sports;

  const Catogory({
    super.key,
    required this.displayImage,
    required this.sports,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                displayImage,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              sports,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }
}
