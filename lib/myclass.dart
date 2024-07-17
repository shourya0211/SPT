import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class MyClass extends StatefulWidget {
  final String videoUrl;

  MyClass({required this.videoUrl});

  @override
  State<MyClass> createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  late Future<String> _urlFuture;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    _urlFuture = _fetchURL();
  }

  Future<String> _fetchMeet() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to your document
      DocumentSnapshot documentSnapshot = await firestore
          .collection('courses')
          .doc('gXpIb2iFFRtd802q7hQp')
          .get();

      // Access the data from the document
      Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;

      // Get the URL field from the document
      String url = data['meet'];

      log(url.toString());

      return url;
    } catch (error) {
      print("Error fetching URL: $error");
      throw error;
    }
  }

  Future<String> _fetchURL() async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to your document
      DocumentSnapshot documentSnapshot = await firestore
          .collection('courses')
          .doc('gXpIb2iFFRtd802q7hQp')
          .get();

      // Access the data from the document
      Map<String, dynamic> data =
      documentSnapshot.data() as Map<String, dynamic>;

      // Get the URL field from the document
      String url = data['url'];

      log(url.toString());

      return url;
    } catch (error) {
      print("Error fetching URL: $error");
      throw error;
    }
  }

  Future<void> _launchUrl(String website) async {
    Uri url = Uri.parse(website);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 30,
            onPressed: () async {
              Future<String> url = _fetchMeet();
              String website = await url;
              _launchUrl(website);
            },
            icon: Icon(
              Icons.video_library,
              color: Colors.green,
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Machine Learning',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: _urlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final url = snapshot.data!;
            final videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(url));
            flickManager = FlickManager(
              videoPlayerController: videoPlayerController,
            );
            return Container(
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
                          child: FlickVideoPlayer(
                            flickManager: flickManager,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 5),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
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
            );
          }
        },
      ),
    );
  }
}
