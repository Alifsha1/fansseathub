import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/sections/assets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

//List searchList = [];

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  late Stream<QuerySnapshot> _stream;
  Map<String, dynamic>? recentSearch;
  List<QueryDocumentSnapshot>? recentSearchResult;
  List<QueryDocumentSnapshot>? searchResults;

  String searchQuery = "";
  @override
  void initState() {
    _stream = FirebaseFirestore.instance.collection('matches').snapshots();
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
                    searchQuery = value;
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
        child: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                searchResults = documents
                    .where((search) =>
                        search['categorycontroller']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        search['team1']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        search['team2']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        search['selectedtype']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                    .toList();

                if (searchResults!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: searchResults!.length,
                    itemBuilder: (context, index) {
                      var thisItems =
                          searchResults![index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: mediaWidth * .93,
                          height: mediaHeight * .23,
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
                                          '${thisItems['categorycontroller']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '${thisItems['gamenocontroller']}',
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
                                          '${thisItems['datecontroller']}'
                                              .toString(),
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
                                        child: Image.network(
                                            '${thisItems['selectedImageteam1']}'),
                                      ),
                                      SizedBox(
                                        width: mediaWidth * .01,
                                      ),
                                      Text(
                                        '${thisItems['team1']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mediaWidth * .07,
                                        width: mediaWidth * .07,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Image.network(
                                            '${thisItems['selectedImageteam2']}'),
                                      ),
                                      SizedBox(
                                        width: mediaWidth * .01,
                                      ),
                                      Text(
                                        '${thisItems['team2']}',
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
                                      '${thisItems['timecontroller']}'
                                          .toString(),
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
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: mediaWidth * .3,
                          height: mediaWidth * .3,
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Image.asset(noresults),
                        ),
                        const Text(
                          'No Search Results.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6fb2d2),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      backgroundColor: Colors.white,
    );
  }
}
