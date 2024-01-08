import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/model/stadiumdetails.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DetailsOfStadium extends StatefulWidget {
  final String stadium;
  const DetailsOfStadium({super.key, required this.stadium});

  @override
  State<DetailsOfStadium> createState() => _DetailsOfStadiumState();
}

class _DetailsOfStadiumState extends State<DetailsOfStadium> {
  late Box<StadiumDetails> stadiumdetailsbox;
  late List<StadiumDetails> stadiumdetailslist;
  @override
  void initState() {
    super.initState();
    stadiumdetailsbox = Hive.box<StadiumDetails>('stadiumdetails');
    stadiumdetailslist = [];
    print(widget.stadium);
    print("Stadium Details List Length: ${stadiumdetailslist.length}");
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    stadiumdetailslist = stadiumdetailsbox.values
        .toList()
        .where((element) =>
            widget.stadium.toLowerCase() == element.stadiumname.toLowerCase())
        .toList();

    final stadiums = stadiumdetailslist;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Spacer(),
                    const Heading(),
                  ],
                ),
                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       AdminSideHeadingsBlack(headings: 'Details'),
                //     ],
                //   ),
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: stadiums.length,
                  itemBuilder: (context, index) {
                    final stadium = stadiums[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              AdminSideHeadingsBlack(
                                  headings: stadium.stadiumname),
                            ],
                          ),
                        ),
                        Container(
                          width: mediaWidth,
                          height: mediaWidth * .8,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Image.file(File(stadium.imagePathstadium)),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              AdminSideHeadingsBlackSize(headings: 'Stands'),
                              Spacer(),
                              AdminSideHeadingsBlackSize(headings: 'Price'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.stands1),
                                  Spacer(),
                                  StadiumText(standname: stadium.ticketcharge1)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.stands2),
                                  Spacer(),
                                  StadiumText(standname: stadium.ticketcharge2)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.stands3),
                                  Spacer(),
                                  StadiumText(standname: stadium.ticketcharge3)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.stands4),
                                  Spacer(),
                                  StadiumText(standname: stadium.ticketcharge4)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  AdminSideHeadingsBlack(
                                      headings: 'Air conditioned Box'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.standsac1),
                                  Spacer(),
                                  StadiumText(
                                      standname: stadium.ticketchargeac1)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  StadiumText(standname: stadium.standsac2),
                                  Spacer(),
                                  StadiumText(
                                      standname: stadium.ticketchargeac2)
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
