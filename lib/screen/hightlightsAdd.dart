import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/dropdown.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/model/highlights.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddHighlights extends StatefulWidget {
  const AddHighlights({super.key});

  @override
  State<AddHighlights> createState() => _AddHighlightsState();
}

class _AddHighlightsState extends State<AddHighlights> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController urlcontroller = TextEditingController();
  String? selectedType;
  // late Box boxname3;
  @override
  void initState() {
    super.initState();
    // boxname3 = Hive.box<Highlights>('highlights');
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final Space = SizedBox(
      height: mediaHeight * .01,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Heading(),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              AdminSideHeadingsBlack(headings: 'Add New Hightlights'),
              SizedBox(
                height: mediaHeight * .05,
              ),
              AdminTextField(
                hinttext: 'Url',
                controller: urlcontroller,
                errormessage: 'Url required',
              ),
              Space,
              DropDownFormField(
                selectedtype: selectedType ?? '',
                hintText: 'selecttype',
                ontypeoption: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              SizedBox(
                height: mediaHeight * .05,
              ),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        // addhighlights();
                        addhighlights();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text(
                      '     Add     ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      )),
    );
  }

  // void addhighlights() {
  //   String highlightskey = DateTime.now().microsecondsSinceEpoch.toString();
  //   Highlights highlights = Highlights(
  //       highlightsKey: highlightskey,
  //       url: urlcontroller.text,
  //       type: selectedType.toString());
  //   boxname3.put(highlightskey, highlights);
  //   urlcontroller.clear();
  // }
  addhighlights() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("youtubevideos").doc();
    String url = urlcontroller.text;
    documentReference.set({
      "url": url,
      "selectedtype": selectedType,
    });
    print("youtubdesaved");
  }
}
