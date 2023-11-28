import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddNextGame extends StatefulWidget {
  const AddNextGame({super.key});

  @override
  State<AddNextGame> createState() => _AddFirstGameState();
}

class _AddFirstGameState extends State<AddNextGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                HeadingWhite()
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Add next game details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [],
            )
          ],
        ),
      )),
    );
  }
}
