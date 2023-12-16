import 'dart:io';

import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GameNameContainer extends StatefulWidget {
  final String team;
  final String fieldHint;
  final String flag;
  final TextEditingController controller;
  final String teamserrormessage;
  File? selectedImageteam1;
  File? selectedImageteam2;

  final void Function()? onTap;

  GameNameContainer(
      {super.key,
      required this.team,
      required this.fieldHint,
      required this.flag,
      required this.controller,
      required this.teamserrormessage,
      this.onTap,
      this.selectedImageteam1,
      this.selectedImageteam2});

  @override
  State<GameNameContainer> createState() => _GameNameContainerState();
}

class _GameNameContainerState extends State<GameNameContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminSideHeadings(headings: widget.team),
          SizedBox(
            height: 10,
          ),
          AdminTextField(
            errormessage: widget.teamserrormessage,
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
          GestureDetector(
            onTap: widget.onTap,
            child: widget.selectedImageteam1 != null ||
                    widget.selectedImageteam2 != null
                ? ClipOval(
                    child: Image.file(
                      widget.selectedImageteam1 ?? widget.selectedImageteam2!,
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                    ),
                  )
                : Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 70,
                  ),
          )
        ],
      ),
    );
  }
  // void ontapfunctionone(){
  //    onTap: widget.onTap1;
  //           child:widget.selectedImageteam1!=null || widget.selectedImageteam2 != null
  //                 ? ClipOval(
  //                   child: Image.file(
  //                   widget.selectedImageteam1 ?? widget.selectedImageteam2!,
  //                     fit: BoxFit.cover,
  //                     width: 140,
  //                     height: 140,
  //                   ),
  //                 )
  // }
}
