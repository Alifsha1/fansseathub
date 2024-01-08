import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fansseathub/helper/widgets/dropdown.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final String selectedtype;
  final void Function(String) ontypeoption;

  const Fieldforsecond({
    super.key,
    required this.timeofgame,
    required this.sportsName,
    required this.category,
    required this.timecontroller,
    required this.categorycontroller,
    required this.typecontroller,
    required this.timeerrorMessage,
    required this.categoryerrorMessage,
    required this.typeerrorMessage,
    required this.selectedtype, required this.ontypeoption,
    
  });

  @override
  State<Fieldforsecond> createState() => _FieldforsecondState();
}

class _FieldforsecondState extends State<Fieldforsecond> {
  final formattime = DateFormat("HH:mm");
  String? selectedType;
  // String? ontypeoption;
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
          DateTimeField(
            controller: widget.timecontroller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'time',
              filled: true,
              fillColor: Colors.white,
            ),
            format: formattime,
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
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
          DropDownFormField(
            selectedtype: selectedType ?? '',
            hintText: 'selecttype',
            ontypeoption: widget.ontypeoption,
          ),
          // Container(
          //     width: MediaQuery.sizeOf(context).width,
          //     decoration: BoxDecoration(
          //         color: Colors.white, borderRadius: BorderRadius.circular(10)),
          //     child: MyDropdown(selectedoption:,)),
          // AdminTextField(
          //   errormessage: widget.typeerrorMessage,
          //   hinttext: 'Enter type',
          //   controller: widget.typecontroller,
          // ),
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
  
  final formatdate = DateFormat("yyyy-MM-dd");

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
          DateTimeField(
            controller: widget.datecontroller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'date',
              filled: true,
              fillColor: Colors.white,
            ),
            format: formatdate,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100),
              );
            },
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
