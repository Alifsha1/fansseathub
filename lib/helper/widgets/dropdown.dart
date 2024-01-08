import 'package:flutter/material.dart';

// class MyDropdown extends StatefulWidget {
// final String selectedoption;

//   const MyDropdown({super.key, required this.selectedoption});

//   @override
//   _MyDropdownState createState() => _MyDropdownState();
// }

// class _MyDropdownState extends State<MyDropdown> {
//   String? selectedOption;
//   List<String> options = ['CRICKET', 'FOOTBALL', 'BADMINTON'];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         DropdownButton(
//           value: selectedOption,
//           items: options.map((option) {
//             return DropdownMenuItem(
//               value: option,
//               child: Text(option),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedOption = value;
//             });
//           },
//           hint: Text('Select an option'),
//         ),
//       ],
//     );
//   }
// }
class DropDownFormField extends StatefulWidget {
  final String selectedtype;
  final ValueChanged<String> ontypeoption;
  final String? Initialvalue;
  final String hintText;
  DropDownFormField(
      {super.key,
      required this.selectedtype,
      required this.ontypeoption,
      this.Initialvalue,
      required this.hintText});

  @override
  State<DropDownFormField> createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  String? selectedvalue;
  List<String> options = ['CRICKET', 'FOOTBALL', 'BADMINTON'];
  @override
  void initState() {
    selectedvalue = widget.Initialvalue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        children: [
          DropdownButtonFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Type is needed';
                } else {
                  return null;
                }
              },
              value: selectedvalue,
              dropdownColor: Colors.teal,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 39, 38, 38),
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 247, 247, 247)))),
              items: options
                  .map((String option) =>
                      DropdownMenuItem(value: option, child: Text(option)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedvalue = value.toString();
                  widget.ontypeoption(selectedvalue!);
                });
              })
        ],
      ),
    );
  }
}
