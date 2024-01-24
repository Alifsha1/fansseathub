// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/playHighlights.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class favorites extends StatefulWidget {
  final Map<dynamic, dynamic>? thisItems;
  final String? id;
  const favorites({super.key, this.thisItems, this.id});

  @override
  State<favorites> createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  //final List<int> _items = [];
  bool isFavorite = true;
  Set<String> favoriteVideoIds = Set<String>();
  @override
  void initState() {
    // DocumentReference documentReference =
    //     FirebaseFirestore.instance.collection("favorites").doc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final mediaWidth = MediaQuery.of(context).size.width;
    // final mediaHeight = MediaQuery.of(context).size.height;
    // final space = SizedBox(
    //   height: mediaHeight * .01,
    // );
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
      body: FutureBuilder(
        future: getFavoriteVideosFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Map<String, dynamic>> favoriteVideos =
                snapshot.data as List<Map<String, dynamic>>;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 9.0,
                  childAspectRatio: 1.6,
                ),
                itemCount: favoriteVideos.length,
                itemBuilder: (context, index) {
                  final video = favoriteVideos[index];
                  final thumbnailUrl = video['thumbnailUrl'];
                  final videoId = video['id'];

                  return GestureDetector(
                    onTap: () async {
                      Map<String, String>? videoInfo =
                          await getYouTubeThumbnail(video['url']);
                      if (videoInfo != null) {
                        // await addToFavorites(
                        //     video['url'],
                        //     videoInfo['videoTitle']!,
                        //     thumbnailUrl['thumbnailUrl']);
                        String videoTitle = videoInfo['videoTitle'] ??
                            'Video Title Not Available';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayHighlights(
                              videourl: video['url'],
                              videotitle: videoTitle,
                            ),
                          ),
                        );
                      }

                      // Handle tap on favorite video if needed
                      // Example: Navigate to a details page
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          color: Colors.amber,
                          child: Image.network(
                            thumbnailUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          child: IconButton(
                            onPressed: () async {
                              Map<String, String>? videoInfo =
                                  await getYouTubeThumbnail(video['id']);
                              // print('removed$videoId');
                              if (videoInfo != null) {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              }
                              if (isFavorite) {
                                favoriteVideoIds.remove(videoId);
                                await removeFromFavorites(videoId);
                                setState(() {});
                              }
                              // Handle removing from favorites if needed
                              // Example: await removeFromFavorites(video['id']);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline_outlined,
                              color: isFavorite ? Colors.red : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

//   Future<List<Map<String, dynamic>>> getFavoriteVideosFromFirestore() async {
//   final favoritesCollection = FirebaseFirestore.instance.collection('favorites');
//   final querySnapshot = await favoritesCollection.get();
//   final favoriteVideos = querySnapshot.docs.map((doc) => doc.data()).toList();
//   return favoriteVideos;
// }
  Future<List<Map<String, dynamic>>> getFavoriteVideosFromFirestore() async {
    final favoritesCollection =
        FirebaseFirestore.instance.collection('favorites');
    final querySnapshot = await favoritesCollection.get();
    final favoriteVideos = querySnapshot.docs.map((doc) {
      return {
        ...doc.data() as Map<String, dynamic>, // Include existing data
        'id': doc.id, // Include the document ID
      };
    }).toList();
    return favoriteVideos;
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

  // Add a function to remove a video from favorites if needed
  // Future<void> removeFromFavorites(String videoId) async {
  //   final favoritesCollection = FirebaseFirestore.instance.collection('favorites');
  //   await favoritesCollection.doc(videoId).delete();
  // }
  Future<void> removeFromFavorites(String documentId) async {
    final favoritesCollection =
        FirebaseFirestore.instance.collection('favorites');
    await favoritesCollection.doc(documentId).delete();
  }
}
