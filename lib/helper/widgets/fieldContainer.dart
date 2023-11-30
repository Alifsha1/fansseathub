import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GameNameContainer extends StatefulWidget {
  final String team;
  final String fieldHint;
  final String flag;
  final TextEditingController controller;
  // final TextEditingController team2controller;
  const GameNameContainer({
    super.key,
    required this.team,
    required this.fieldHint,
    required this.flag,
    required this.controller,
    //required this.team2controller,
  });

  @override
  State<GameNameContainer> createState() => _GameNameContainerState();
}

class _GameNameContainerState extends State<GameNameContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminSideHeadings(headings: widget.team),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            controller: widget.controller,
            hinttext: widget.fieldHint,
          ),
          SizedBox(
            height: 10,
          ),
          AdminSideHeadings(headings: widget.flag),
          SizedBox(
            height: 10,
          ),
          Icon(
            Icons.image_outlined,
            color: Colors.white,
            size: 70,
          )
        ],
      ),
    );
  }
}
