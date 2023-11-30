import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Fieldforsecond extends StatefulWidget {
  final TextEditingController timecontroller;
  final TextEditingController categorycontroller;
  final TextEditingController typecontroller;
  final String timeofgame;
  final String sportsName;
  final String category;

  const Fieldforsecond(
      {super.key,
      required this.timeofgame,
      required this.sportsName,
      required this.category,
      required this.timecontroller,
      required this.categorycontroller,
      required this.typecontroller});

  @override
  State<Fieldforsecond> createState() => _FieldforsecondState();
}

class _FieldforsecondState extends State<Fieldforsecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.5,
      child: Column(
        children: [
          Row(
            children: [
              AdminSideHeadings(headings: widget.timeofgame),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            controller: widget.timecontroller,
            hinttext: 'Enter time',
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.category),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter category',
            controller: widget.categorycontroller,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.sportsName),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter type',
            controller: widget.typecontroller,
          ),
        ],
      ),
    );
  }
}

class DateContainer extends StatefulWidget {
  final TextEditingController datecontroller;
  final TextEditingController gamenocontroller;
  final TextEditingController stadiumcontroller;
  final String gameno;
  final String dateofgame;
  final String stadiumName;
  const DateContainer({
    super.key,
    required this.stadiumName,
    required this.gameno,
    required this.dateofgame,
    required this.datecontroller,
    required this.gamenocontroller,
    required this.stadiumcontroller,
  });

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.5,
      child: Column(
        children: [
          Row(
            children: [
              AdminSideHeadings(headings: widget.dateofgame),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter date',
            controller: widget.datecontroller,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.gameno),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter no',
            controller: widget.gamenocontroller,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.stadiumName),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter stadium',
            controller: widget.stadiumcontroller,
          ),
        ],
      ),
    );
  }
}
