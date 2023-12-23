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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 2,
                color: Color(0x0D000000),
              )
            ]),
        width: MediaQuery.of(context).size.width * 0.88,
        height: MediaQuery.of(context).size.height / 2.85,
        child: Stack(
          children: [
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: 15,
                child: Column(
                  children: [
                    SizedBox(
                      child: Text(
                        sports,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.88,
                height: MediaQuery.of(context).size.height * 0.280,
                child: Image.asset(
                  displayImage,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
