import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/hive/hive_Functions.dart';

import 'package:flutter/material.dart';
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
            child: Column(
              children: [
                Container(
                  width: mediaWidth,
                  height: mediaWidth * .54,
                  decoration: BoxDecoration(
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
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                space,
                Divider(
                  color: Colors.black,
                  thickness: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
