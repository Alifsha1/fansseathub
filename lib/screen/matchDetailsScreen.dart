import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MatchDetailsScreen extends StatefulWidget {
  const MatchDetailsScreen({super.key});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back_ios_new),
                SizedBox(
                  width: 15,
                ),
                AdminSideHeadingsBlack(headings: 'CRICKET')
              ],
            ),
          ],
        ),
      )),
    );
  }
}
