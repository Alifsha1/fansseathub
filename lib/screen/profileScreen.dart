// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  String username;
  String email;
  ProfileScreen({super.key, required this.email, required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                size: 200,
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Full Name",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    widget.username,
                    style: const TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "email ",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
