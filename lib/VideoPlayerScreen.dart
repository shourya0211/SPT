import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final String Description;
  final String Title;

  VideoPlayerScreen({required this.videoUrl,required this.Description,required this.Title});

  @override
  Widget build(BuildContext context) {
    final FlickManager flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        videoUrl,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the background color of the AppBar to black
        title: Text(
          Title,
          style: TextStyle(
            color: Colors.white, // Set the font color of the title to white
          ),
        ),
      ),

      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FlickVideoPlayer(flickManager: flickManager),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      Description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality for the buy button here
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
