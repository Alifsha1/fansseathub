import 'dart:io';

import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String typeHeading;
  final String? type;
  const MatchDetailsScreen({
    super.key,
    this.type,
    required this.typeHeading,
  });

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {

  late Box<MatchDetails> matchdetailsbox;
  late List<MatchDetails> matchdetailslist;
  @override
  void initState() {
 
    super.initState();
    matchdetailsbox = Hive.box<MatchDetails>('matchdetails');
    matchdetailslist = [];
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    matchdetailslist = matchdetailsbox.values
        .toList()
        .where((element) =>
            widget.type!.toLowerCase() == element.typeofgame.toLowerCase())
        .toList();
    final matchs = matchdetailslist[0];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back_ios_new)),
                  const SizedBox(
                    width: 15,
                  ),
                  AdminSideHeadingsBlack(headings: widget.typeHeading)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Container(
                  width: mediaHeight,
                  height: mediaHeight * .28,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, right: 170, left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              matchs.typeofgame,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const Spacer(),
                            Text(
                              matchs.date,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const Spacer(),
                            Text(
                              matchs.time,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: mediaWidth * .13,
                                  width: mediaWidth * .13,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.file(File(matchs.imagePath1)),
                                ),
                                Text(
                                  matchs.team1,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const Text(
                              'VS',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: mediaWidth * .13,
                                  width: mediaWidth * .13,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Image.file(File(matchs.imagePath2)),
                                ),
                                Text(
                                  matchs.team2,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              matchs.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              matchs.gameno,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text('VIEW DETAILS')),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const Row(
                children: [
                  Text(
                    'Up Coming Matches',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                width: mediaWidth,
                height: mediaHeight * .2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: matchdetailslist.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    } else {
                      MatchDetails matchss = matchdetailslist[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: mediaWidth * .93,
                        height: mediaHeight * .2,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 17, right: 17, left: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        matchss.category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        matchss.gameno,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        matchss.date,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: mediaWidth * .07,
                                      width: mediaWidth * .07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:
                                          Image.file(File(matchss.imagePath1)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: mediaWidth * .07,
                                      width: mediaWidth * .07,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:
                                          Image.file(File(matchss.imagePath2)),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Starts at ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    matchss.time,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
     
    );
  }
}
