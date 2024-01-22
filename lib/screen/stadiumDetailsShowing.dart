import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
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
  // late Box<StadiumDetails> stadiumdetailsbox;
  // late List<StadiumDetails> stadiumdetailslist;
  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    print(widget.stadium);
    super.initState();
    // stadiumdetailsbox = Hive.box<StadiumDetails>('stadiumdetails');
    // stadiumdetailslist = [];
    _stream = FirebaseFirestore.instance
        .collection('stadiums')
        .where('stadiumname',
            isEqualTo: widget.stadium)
        .snapshots();
    print(_stream);
     print(widget.stadium);
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    //final mediaHeight = MediaQuery.of(context).size.height;
    // stadiumdetailslist = stadiumdetailsbox.values
    //     .toList()
    //     .where((element) =>
    //         widget.stadium.toLowerCase() == element.stadiumname.toLowerCase())
    //     .toList();

    // final stadiums = stadiumdetailslist;

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
                StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Some Error occured${snapshot.error}"),
                      );
                    }
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> document = querySnapshot.docs;
                      List<Map> items =
                          document.map((e) => e.data() as Map).toList();
                      //             return ListView.builder(
                      // shrinkWrap: true,
                      // itemCount: stadiums.length,
                      // itemBuilder: (context, index) {
                      //   final stadium = stadiums[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                AdminSideHeadingsBlack(
                                    headings: '${items[0]['stadiumname']}'),
                              ],
                            ),
                          ),
                          Container(
                            width: mediaWidth,
                            height: mediaWidth * .8,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Image.network(
                                "${items[0]['imagePathstadium']}"),
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
                                    StadiumText(
                                        standname: '${items[0]['stands1']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketcharge1']}')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    StadiumText(
                                        standname: '${items[0]['stands2']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketcharge2']}')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    StadiumText(
                                        standname: '${items[0]['stands3']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketcharge3']}')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    StadiumText(
                                        standname: '${items[0]['stands4']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketcharge4']}')
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                    StadiumText(
                                        standname: '${items[0]['standsac1']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketchargeac1']}')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    StadiumText(
                                        standname: '${items[0]['standsac2']}'),
                                    const Spacer(),
                                    StadiumText(
                                        standname:
                                            '${items[0]['ticketchargeac2']}')
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                      //},
                      //),
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
