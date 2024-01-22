// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/hive/hive_Functions.dart';
import 'package:fansseathub/model/highlights.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayHighlights extends StatefulWidget {
  final String videourl;
  final String videotitle;

  const PlayHighlights({
    super.key,
    required this.videourl,
    required this.videotitle,
  });

  @override
  State<PlayHighlights> createState() => _PlayHighlightsState();
}

class _PlayHighlightsState extends State<PlayHighlights> {
  late String videotitle;

  @override
  void initState() {
    super.initState();
    videotitle = VideoUtils.extractVideoId(widget.videourl);
  }

  @override
  Widget build(BuildContext context) {
    String formattedTitle = widget.videotitle
        .replaceAll('_', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    final space = SizedBox(
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
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: mediaWidth,
                  height: mediaWidth * .54,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: YoutubePlayer(
                      controller: YoutubePlayerController(
                    initialVideoId: VideoUtils.extractVideoId(widget.videourl),
                  )),
                ),
                space,
                Text(
                  formattedTitle,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                space,
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: mediaWidth * 0.87,
                        height: mediaHeight,
                        decoration: const BoxDecoration(),
                         child:FutureBuilder(
                            future: getYoutubeVideosWithThumbnailsFromFirestore(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                final List<Map<String, dynamic>>
                                    videosWithThumbnails =
                                    snapshot.data as List<Map<String, dynamic>>;
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15.0,
                                    mainAxisSpacing: 9.0,
                                  ),
                                  itemCount: videosWithThumbnails.length,
                                  itemBuilder: (context, index) {
                                    final video = videosWithThumbnails[index]
                                        ['video'] ;
                                    final thumbnailUrl =
                                        videosWithThumbnails[index]
                                            ['thumbnailUrl'];
                                    return GestureDetector(
                                      onTap: () async {
                                        Map<String, String>? videoInfo =
                                            await getYouTubeThumbnail(video['url']);
                                        if (videoInfo != null) {
                                          String videoTitle =
                                              videoInfo['videoTitle'] ??
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
                                      child: Image.network(
                                        thumbnailUrl['thumbnailUrl'],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                        // FutureBuilder(
                        //     future: getYoutubeVideosWithThumbnailsFromFirestore(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.done) {
                        //         final List<Map<String, dynamic>>
                        //             videosWithThumbnails =
                        //             snapshot.data as List<Map<String, dynamic>>;
                        //         return GridView.builder(
                        //           gridDelegate:
                        //               const SliverGridDelegateWithFixedCrossAxisCount(
                        //                   crossAxisCount: 2,
                        //                   crossAxisSpacing: 15.0,
                        //                   mainAxisSpacing: 9.0),
                        //           itemCount: videosWithThumbnails.length,
                        //           itemBuilder: (context, index) {
                        //             final video = videosWithThumbnails[index]
                        //                 ['video'] as Highlights;
                        //             final thumbnailUrl =
                        //                 videosWithThumbnails[index]
                        //                     ['thumbnailUrl'];
                        //             return GestureDetector(
                        //               onTap: () async {
                        //                 Map<String, String>? videoInfo =
                        //                     await getYouTubeThumbnail(
                        //                         video.url);
                        //                 if (videoInfo != null) {
                        //                   String videoTitle =
                        //                       videoInfo['videoTitle'] ??
                        //                           'Video Title Not Available';

                        //                   Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           PlayHighlights(
                        //                         videourl: video.url,
                        //                         videotitle: videoTitle,
                        //                       ),
                        //                     ),
                        //                   );
                        //                 }
                        //               },
                        //               child: Image.network(
                        //                 thumbnailUrl['thumbnailUrl'],
                        //                 fit: BoxFit.fill,
                        //                 //height: 120,
                        //               ),
                        //             );
                        //           },
                        //         );
                        //       } else {
                        //         return const Center(
                        //             child: CircularProgressIndicator());
                        //       }
                        //     }),
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
  //   final box = await Hive.box<Highlights>('highlights');
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
  Future<List<Map<String, dynamic>>> getYoutubeVideosWithThumbnailsFromFirestore() async {
  final collectionReference = FirebaseFirestore.instance.collection('youtubevideos');
  final querySnapshot = await collectionReference.get();
  final videos = querySnapshot.docs.map((doc) => doc.data()).toList();
  final videosWithThumbnails = <Map<String, dynamic>>[];

  for (final video in videos) {
     final url = video['url'] as String; 
    final thumbnailUrl = await getYouTubeThumbnail(url);
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

      if (video != null) {
        final thumbnailUrl = video.thumbnails.highResUrl;
        final videoTitle = video.title;

        return {'thumbnailUrl': thumbnailUrl, 'videoTitle': videoTitle};
      }
    }

    return null;
  }
}
