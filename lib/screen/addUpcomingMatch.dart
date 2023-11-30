import 'package:fansseathub/helper/widgets/addingField.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddUpcomingGame extends StatefulWidget {
  const AddUpcomingGame({super.key});

  @override
  State<AddUpcomingGame> createState() => _AddFirstGameState();
}

class _AddFirstGameState extends State<AddUpcomingGame> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController team1controller = TextEditingController();
  final TextEditingController team2controller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController categorycontroller = TextEditingController();
  final TextEditingController typecontroller = TextEditingController();
  final TextEditingController gamenocontroller = TextEditingController();
  final TextEditingController stadiumcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 14, right: 14),
          child: Form(
            key: formkey,
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
                Row(
                  children: [
                    Text(
                      'Add upcoming game details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GameAddingField(
                  team1Controller: team1controller,
                  team2Controller: team2controller,
                  dateController: datecontroller,
                  timeController: timecontroller,
                  categoryController: categorycontroller,
                  gamenoController: gamenocontroller,
                  typeController: typecontroller,
                  stadiumController: stadiumcontroller,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text(
                        '     Submit    ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
