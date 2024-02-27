import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

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
          'Machine Learning',
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
                      'Machine learning is a branch of artificial intelligence (AI) '
                          'that focuses on developing algorithms and techniques that enable computers to learn from '
                          'and make predictions or decisions based on data. Instead of being explicitly '
                          'programmed to perform a certain task, machine learning systems are designed to learn from large datasets and improve their performance over time.',
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
