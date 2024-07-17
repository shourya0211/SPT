import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  final String name;
  final String course;
  final String userId;
  DemoPage({Key? key, required this.name,required this.course, required this.userId}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  var curiculamData;
  var reviewsData;
  String desc = "";
  String video = "";
  String price="";
  String courseIndex="";
  bool loading = false;
  Future<void> getData() async {
    final ref = await FirebaseFirestore.instance
        .collection("demo_course")
        .where('name', isEqualTo: widget.name)
        .get();

    ref.docs.forEach((doc) {
      setState(() {
        desc = doc["desc"];
        video = doc["video"];
        price=doc["price"];
        courseIndex=doc['index'];
        print(courseIndex);
        // flickManager = FlickManager(
        //   videoPlayerController:
        //   VideoPlayerController.network(video), // Pass 'video' URL here
        // );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("data"),);
  }
}
