import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatefulWidget {

  final String Title;

  VideoPlayerScreen({required this.Title});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  @override
  Widget build(BuildContext context) {
    String desc = "";
    String video = "";
    Future<void> getData() async {
      final ref = await FirebaseFirestore.instance
          .collection("demo_course")
          .where('name', isEqualTo: widget.Title)
          .get();

      ref.docs.forEach((doc) {
        setState(() {
          desc = doc["desc"];
          video = doc["video"];
        });
      });

      log(desc);
    }

    @override
    void initState() {
      super.initState();
      getData();
    }

    bool showInfo = false; // State to manage whether to show information or not

    void toggleInfo() {
      setState(() {
        showInfo = !showInfo; // Toggle the state when the button is clicked
      });
    }
    final FlickManager flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        video,
      ),
    );


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the background color of the AppBar to black
        title: Text(
          widget.Title,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: toggleInfo,
                      child: Text('Description'),
                    ),
                    SizedBox(height: 20),
                    if (showInfo) // Show information only when showInfo is true
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            desc,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),

                        ],
                      ),
                  ],
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