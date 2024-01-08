import 'dart:io';

import 'package:fansseathub/helper/widgets/fieldContainer.dart';
import 'package:fansseathub/helper/widgets/fieldContainerTwo.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameAddingField extends StatefulWidget {
  final TextEditingController team1Controller;
  final TextEditingController team2Controller;
  final TextEditingController timeController;
  final TextEditingController dateController;
  final TextEditingController categoryController;
  final TextEditingController typeController;
  final TextEditingController stadiumController;
  final TextEditingController gamenoController;
  final void Function()? onTap1;
  final void Function()? onTap2;
  File? imageSelectedteam1;
  File? imageSelectedteam2;
  final String selectedtype;
  // final String ontypeoption;
  final void Function(String) ontypeoption;

  GameAddingField({
    super.key,
    required this.team1Controller,
    required this.team2Controller,
    required this.timeController,
    required this.dateController,
    required this.categoryController,
    required this.typeController,
    required this.stadiumController,
    required this.gamenoController,
    required this.onTap1,
    required this.onTap2,
    required this.imageSelectedteam1,
    required this.imageSelectedteam2,
    required this.selectedtype, required this.ontypeoption,
    // required this.ontypeoption,
  });

  @override
  State<GameAddingField> createState() => _GameAddingFieldState();
}

class _GameAddingFieldState extends State<GameAddingField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameNameContainer(
          teamserrormessage: "team name cannot be empty",
          controller: widget.team1Controller,
          fieldHint: 'Enter Team',
          flag: 'flag team 1',
          team: 'Team 1',
          onTap: widget.onTap1,
          selectedImageteam1: widget.imageSelectedteam1,
        ),
        const SizedBox(
          width: 5,
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: AdminSideHeadings(headings: 'VS'),
        ),
        const SizedBox(
          width: 5,
        ),
        GameNameContainer(
          teamserrormessage: "team name cannot be empty",
          controller: widget.team2Controller,
          fieldHint: 'Enter Team',
          flag: 'flag team 2',
          team: 'Team 2',
          onTap: widget.onTap2,
          selectedImageteam2: widget.imageSelectedteam2,
        ),
        Fieldforsecond(
          timeerrorMessage: "time name cannot be empty",
          categoryerrorMessage: "category name cannot be empty",
          typeerrorMessage: "type name cannot be empty",
          timecontroller: widget.timeController,
          categorycontroller: widget.categoryController,
          typecontroller: widget.typeController,
          timeofgame: 'Time',
          category: 'Category',
          sportsName: 'Type',
          selectedtype: widget.selectedtype,
          ontypeoption: widget.ontypeoption,
          // ontypeotion: widget.ontypeoption,
        ),
        const SizedBox(
          width: 48,
        ),
        DateContainer(
          dateerrorMessage: "date name cannot be empty",
          gameerrorMessage: "gameno name cannot be empty",
          stadiumerrorMessage: "stadium name cannot be empty",
          datecontroller: widget.dateController,
          gamenocontroller: widget.gamenoController,
          stadiumcontroller: widget.stadiumController,
          dateofgame: 'Date',
          gameno: 'Game no',
          stadiumName: 'Stadium',
        )
      ],
    );
  }
}
