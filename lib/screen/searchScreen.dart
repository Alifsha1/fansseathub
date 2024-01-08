import 'dart:io';


import 'package:fansseathub/model/matchdetails.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

late Box<MatchDetails> matchdetailbox;
late List<MatchDetails> matchdetailList;
List searchList = [];

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    matchdetailbox = Hive.box<MatchDetails>('matchdetails');
    matchdetailList = matchdetailbox.values.toList();
    searchList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 45,
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    search();
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: 'search',
                  hintStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 64, 63, 63),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
              child: matchdetailList.isNotEmpty
                  ? _searchController.text.isNotEmpty
                      ? searchList.isEmpty
                          ? const Center(
                              child: Text('Sorry, No result found'),
                            )
                          : ListView.builder(
                            itemCount: searchList.length,
                            itemBuilder: (context, index) {
                           
                                final detailsList = searchList[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: mediaWidth * .93,
                                    height: mediaHeight * .2,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
                                                    detailsList.category,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    detailsList.gameno,
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
                                                    detailsList.date,
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
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: mediaWidth * .07,
                                                  width: mediaWidth * .07,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.file(File(
                                                      detailsList.imagePath1)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: mediaWidth * .07,
                                                  width: mediaWidth * .07,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.file(File(
                                                      detailsList.imagePath2)),
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
                                                detailsList.time,
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
                                  ),
                                );
                              
                            })
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: mediaHeight - 200,
                                  child: ListView.builder(
                                    itemCount: matchdetailList.length,
                                    itemBuilder: (context, index) {
                                      // MatchDetails matchss = matchdetailList[index];
                                      final match = matchdetailList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          width: mediaWidth * .93,
                                          height: mediaHeight * .2,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
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
                                                          match.category,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        Text(
                                                          match.gameno,
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
                                                          match.date.toString(),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height:
                                                            mediaWidth * .07,
                                                        width: mediaWidth * .07,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.file(File(
                                                            match.imagePath1)),
                                                      ),
                                                      SizedBox(
                                                        width: mediaWidth * .01,
                                                      ),
                                                      Text(
                                                        match.team1,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height:
                                                            mediaWidth * .07,
                                                        width: mediaWidth * .07,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Image.file(File(
                                                            match.imagePath2)),
                                                      ),
                                                      SizedBox(
                                                        width: mediaWidth * .01,
                                                      ),
                                                      Text(
                                                        match.team2,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      )
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
                                                      match.time.toString(),
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
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  : Container())),
    );
  }

  void search() {
    
    if (_searchController.text.isNotEmpty) {
      searchList = matchdetailbox.values
          .where((detailsList) =>
              detailsList.team1.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
              detailsList.team2.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
              detailsList.category.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ))
          .toList();
    }
  }
}
