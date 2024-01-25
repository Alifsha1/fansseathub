import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/sections/assets.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(
      height: 10,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'privacy & policy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdminSideHeadingsBlack(headings: 'About FanSeatHub'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  aboutheadingp,
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      aboutmainhead1,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                space,
                Row(
                  children: [
                    Text(aboutmainhead2,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                  ],
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      abouthead2,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp2,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      abouthead3,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp3,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead4,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp4,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead5,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp5,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead6,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp6,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      aboutmainhead3,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead7,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp7,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead8,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp8,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead9,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp9,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      abouthead10,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutp10,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                space,
                Row(
                  children: [
                    Text(
                      aboutmainhead4,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                space,
                Text(
                  aboutmainhead4p,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
