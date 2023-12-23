import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Fieldforsecond extends StatefulWidget {
  final TextEditingController timecontroller;
  final TextEditingController categorycontroller;
  final TextEditingController typecontroller;
  final String timeofgame;
  final String sportsName;
  final String category;
  final String timeerrorMessage;
  final String categoryerrorMessage;
  final String typeerrorMessage;

  const Fieldforsecond(
      {super.key,
      required this.timeofgame,
      required this.sportsName,
      required this.category,
      required this.timecontroller,
      required this.categorycontroller,
      required this.typecontroller,
      required this.timeerrorMessage,
      required this.categoryerrorMessage,
      required this.typeerrorMessage});

  @override
  State<Fieldforsecond> createState() => _FieldforsecondState();
}

class _FieldforsecondState extends State<Fieldforsecond> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            children: [
              AdminSideHeadings(headings: widget.timeofgame),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.timeerrorMessage,
            controller: widget.timecontroller,
            hinttext: 'Enter time',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.category),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.categoryerrorMessage,
            hinttext: 'Enter category',
            controller: widget.categorycontroller,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.sportsName),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.typeerrorMessage,
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
  final String dateerrorMessage;
  final String gameerrorMessage;
  final String stadiumerrorMessage;

  const DateContainer({
    super.key,
    required this.stadiumName,
    required this.gameno,
    required this.dateofgame,
    required this.datecontroller,
    required this.gamenocontroller,
    required this.stadiumcontroller,
    required this.dateerrorMessage,
    required this.gameerrorMessage,
    required this.stadiumerrorMessage,
  });

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            children: [
              AdminSideHeadings(headings: widget.dateofgame),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.dateerrorMessage,
            hinttext: 'Enter date',
            controller: widget.datecontroller,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.gameno),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            hinttext: 'Enter no',
            errormessage: widget.gameerrorMessage,
            controller: widget.gamenocontroller,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AdminSideHeadings(headings: widget.stadiumName),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.stadiumerrorMessage,
            hinttext: 'Enter stadium',
            controller: widget.stadiumcontroller,
          ),
        ],
      ),
    );
  }
}
