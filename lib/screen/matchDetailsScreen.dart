// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';

import 'package:fansseathub/model/highlights.dart';
import 'package:fansseathub/model/matchdetails.dart';
import 'package:fansseathub/screen/playHighlights.dart';
import 'package:fansseathub/screen/stadiumDetailsShowing.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
  // late Box<MatchDetails> matchdetailsbox;
  // late List<MatchDetails> matchdetailslist;
  late Stream<QuerySnapshot> _stream;
  String stadiumname = ' ';
  @override
  void initState() {
    super.initState();

    // matchdetailsbox = Hive.box<MatchDetails>('matchdetails');
    // matchdetailslist = [];
    _stream = FirebaseFirestore.instance
        .collection('matches')
        .where('selectedtype', isEqualTo: widget.type!.toUpperCase())
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    // matchdetailslist = matchdetailsbox.values
    //     .toList()
    //     .where((element) =>
    //         widget.type!.toLowerCase() == element.typeofgame.toLowerCase())
    //     .toList();
    // final matchs = matchdetailslist[0];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Some Error occured${snapshot.error}"),
                          );
                        }
                        if (snapshot.hasData) {
                          QuerySnapshot querySnapshot = snapshot.data;
                          List<QueryDocumentSnapshot> document =
                              querySnapshot.docs;
                          List<Map> items =
                              document.map((e) => e.data() as Map).toList();
                          stadiumname = items[0]['stadiumcontroller'];
                          // return ListView.builder(
                          //   itemCount: 1,
                          //   itemBuilder: (context, index) {
                          //  Map thisItems = items[0];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, right: 160, left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${items[0]['typecontroller']}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${items[0]['datecontroller']}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${items[0]['timecontroller']}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: mediaWidth * .13,
                                          width: mediaWidth * .13,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Image.network(
                                              "${items[0]['selectedImageteam1']}"),
                                        ),
                                        Text(
                                          '${items[0]['team1']}',
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Image.network(
                                              "${items[0]['selectedImageteam2']}"),
                                        ),
                                        Text(
                                          '${items[0]['team2']}',
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                      '${items[0]['categorycontroller']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      '${items[0]['gamenocontroller']}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                          //   },
                          // );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsOfStadium(
                                    stadium: stadiumname,
                                  )));
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
                  height: mediaHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: SizedBox(
                      width: mediaWidth,
                      height: mediaHeight * .22,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text("Some Error occured${snapshot.error}"),
                            );
                          }
                          if (snapshot.hasData) {
                            QuerySnapshot<Object?>? querySnapshot =
                                snapshot.data;
                            List<QueryDocumentSnapshot> document =
                                querySnapshot!.docs;
                            List<Map> items =
                                document.map((e) => e.data() as Map).toList();
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length - 1,
                              itemBuilder: (BuildContext context, int index) {
                                Map thisItems = items[index + 1];
                                // if (index == 0) {
                                //   return const SizedBox.shrink();
                                // } else {
                                // MatchDetails matchss = matchdetailslist[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsOfStadium(
                                          stadium:
                                              '${thisItems['stadiumcontroller']}',
                                        ),
                                      ),
                                    );
                                  },
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
                                                    '${thisItems['categorycontroller']}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
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
                                                    '${thisItems['datecontroller']}',
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.network(
                                                      "${thisItems['selectedImageteam1']}"),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Image.network(
                                                      "${thisItems['selectedImageteam2']}"),
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
                                                '${thisItems['timecontroller']}',
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
                                // }
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Container(
                            //   width: mediaWidth * 0.87,
                            //   height: mediaHeight,
                            //   decoration: const BoxDecoration(
                            //       // borderRadius: BorderRadius.circular(10),
                            //       ),
                            //   child: FutureBuilder(
                            //       future: getYoutubeVideosWithThumbnailsFromFirestore(),
                            //       builder: (context, snapshot) {
                            //         if (snapshot.connectionState ==
                            //             ConnectionState.done) {
                            //           final List<Map<String, dynamic>>
                            //               videosWithThumbnails = snapshot.data
                            //                   as List<Map<String, dynamic>>;
                            //           return GridView.builder(
                            //             //   child: ListView.builder(
                            //             gridDelegate:
                            //                 const SliverGridDelegateWithFixedCrossAxisCount(
                            //                     crossAxisCount: 2,
                            //                     crossAxisSpacing: 15.0,
                            //                     mainAxisSpacing: 9.0),
                            //             itemCount: videosWithThumbnails.length,
                            //             itemBuilder: (context, index) {
                            //               final video =
                            //                   videosWithThumbnails[index]
                            //                       ['video'] ;
                            //               final thumbnailUrl =
                            //                   videosWithThumbnails[index]
                            //                       ['thumbnailUrl'];
                            //               return GestureDetector(
                            //                 onTap: () async {
                            //                   Map<String, String>? videoInfo =
                            //                       await getYouTubeThumbnail(
                            //                           video.url);
                            //                   if (videoInfo != null) {
                            //                     String videoTitle = videoInfo[
                            //                             'videoTitle'] ??
                            //                         'Video Title Not Available';

                            //                     Navigator.push(
                            //                       context,
                            //                       MaterialPageRoute(
                            //                         builder: (context) =>
                            //                             PlayHighlights(
                            //                           // videourl: videos[index].url,
                            //                           videourl: video.url,
                            //                           videotitle: videoTitle,

                            //                           //  videoid: ,
                            //                         ),
                            //                       ),
                            //                     );
                            //                   }
                            //                 },
                            //                 child: Image.network(
                            //                   thumbnailUrl['thumbnailUrl'],
                            //                   fit: BoxFit.fill,
                            //                   //height: 120,
                            //                 ),
                            //               );
                            //             },
                            //             // ),
                            //           );
                            //         } else {
                            //           return const Center(
                            //               child: CircularProgressIndicator());
                            //         }
                            //       }),
                            // ),
                            Container(
                              width: mediaWidth * 0.87,
                              height: mediaHeight,
                              decoration: const BoxDecoration(),
                              child: FutureBuilder(
                                future:
                                    getYoutubeVideosWithThumbnailsFromFirestore(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final List<Map<String, dynamic>>
                                        videosWithThumbnails = snapshot.data
                                            as List<Map<String, dynamic>>;
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15.0,
                                        mainAxisSpacing: 9.0,
                                        childAspectRatio: 1.6
                                      ),
                                      itemCount: videosWithThumbnails.length,
                                      itemBuilder: (context, index) {
                                        final video =
                                            videosWithThumbnails[index]
                                                ['video'];
                                        final thumbnailUrl =
                                            videosWithThumbnails[index]
                                                ['thumbnailUrl'];
                                        return GestureDetector(
                                          onTap: () async {
                                            Map<String, String>? videoInfo =
                                                await getYouTubeThumbnail(
                                                    video['url']);
                                            if (videoInfo != null) {
                                              String videoTitle = videoInfo[
                                                      'videoTitle'] ??
                                                  'Video Title Not Available';
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayHighlights(
                                                    videourl: video['url'],
                                                    videotitle: videoTitle,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            color:Colors.amber ,
                                            child: Image.network(
                                              thumbnailUrl['thumbnailUrl'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<List<Map<String, dynamic>>> getYoutubeVideosWithThumbnails() async {
  //   final box = await Hive.openBox<Highlights>('highlights');
  //   final videos = box.values.toList();
  //   final videosWithThumbnails = <Map<String, dynamic>>[];

  //   for (final video in videos) {
  //     final thumbnailUrl = await getYouTubeThumbnail(video.url);
  //     videosWithThumbnails.add({
  //       'video': video,
  //       'thumbnailUrl': thumbnailUrl,
  //     });
  //   }

  //   return videosWithThumbnails;
  // }
  Future<List<Map<String, dynamic>>>
      getYoutubeVideosWithThumbnailsFromFirestore() async {
    final collectionReference =
        FirebaseFirestore.instance.collection('youtubevideos');
    final querySnapshot = await collectionReference.get();
    final videos = querySnapshot.docs.map((doc) => doc.data()).toList();
    final videosWithThumbnails = <Map<String, dynamic>>[];

    for (final video in videos) {
      final thumbnailUrl = await getYouTubeThumbnail(video['url']);
      videosWithThumbnails.add({
        'video': video,
        'thumbnailUrl': thumbnailUrl,
      });
    }

    return videosWithThumbnails;
  }

  Future<Map<String, String>?> getYouTubeThumbnail(String videoUrl) async {
    final regExp = RegExp(
        r'(?<=watch\?v=|/videos/|embed\/|youtu.be\/|\/v\/|\/e\/|\?v=|&v=|\/videos\/|\/embed\/|youtu.be\/|\/v\/|\/e\/|watch\?v%3D|watch\?feature=player_embedded&v=|%2Fvideos%2F|embed&v=|%2Fv%2F|e&v=|v=|t=%2Fvideos%2F|t=%2Fv%2F|e&v=|http(?:s)?:\/\/www\.youtube\.com\/playlist\?list=|http(?:s)?:\/\/www\.youtube\.com\/user\/[^\/]+#watch\/|http(?:s)?:\/\/www\.youtube\.com\/c\/[^\/]+\/[^\/]+#watch\/|http(?:s)?:\/\/www\.youtube\.com\/user\/[^\/]+\/videos\/|http(?:s)?:\/\/www\.youtube\.com\/u\/[^\/]+\/[^\/]+#watch\/|http(?:s)?:\/\/youtu\.be\/)([^"&?\/\s]{11})');
    final match = regExp.firstMatch(videoUrl);
    final videoId = match?.group(1);

    if (videoId != null) {
      final youtubeExplode = YoutubeExplode();
      final video = await youtubeExplode.videos.get(videoId);

      // ignore: unnecessary_null_comparison
      if (video != null) {
        final thumbnailUrl = video.thumbnails.highResUrl;
        final videoTitle = video.title;

        return {'thumbnailUrl': thumbnailUrl, 'videoTitle': videoTitle};
      }
    }

    return null;
  }
}
