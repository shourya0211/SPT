
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:video_player/video_player.dart';

class Demo1 extends StatefulWidget {
  final String name;
  final String course;
  final String userId;
  Demo1({Key? key, required this.name,required this.course, required this.userId}) : super(key: key);

  @override
  State<Demo1> createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  var curiculamData;
  var reviewsData;
  String desc = "";
  String video = "";
  String price="";
  String courseIndex="";
  bool loading = false;
  late FlickManager flickManager; // Declare flickManager as a late variable

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
        curiculamData=doc['curriculum'];
        reviewsData=doc['reviews'];
        print(courseIndex);
        flickManager = FlickManager(
          videoPlayerController:
          VideoPlayerController.network(video), // Pass 'video' URL here
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    //fetchCurriculum();
  }

  @override
  void dispose() {
    flickManager.dispose(); // Dispose the flickManager when the widget is disposed
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return desc.isEmpty
        ? Center(
      child: CircularProgressIndicator(color: Colors.white,),
    )
        : DefaultTabController(
      length: 3,
          child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            widget.name,
            style: TextStyle(
              color:
              Colors.white, // Set the font color of the title to white
            ),
          ),
                ),
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
                AspectRatio(aspectRatio: 16/9,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: FlickVideoPlayer(flickManager: flickManager),),),
                TabBar(
                  dividerColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Description",
                    ),
                    Tab(
                      text: "Curriculum",
                    ),
                    Tab(
                      text: "Reviews",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: double.infinity,
                          //height: 1000,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(desc,style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                          itemCount: curiculamData.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(curiculamData[index],
                                width: double.infinity,
                                // height: double.infinity,
                                // fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    // Image has finished loading
                                    return child;
                                  } else {
                                    // Image is still loading
                                    return Container(
                                      child: const Center(
                                        child: SizedBox(
                                          width: 34,
                                          height: 34,
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: ListView.builder(
                          itemCount: reviewsData.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: ListTile(title: Text(reviewsData[index],style: TextStyle(color: Colors.white),),)),
                            );
                          }
                      ),
                    ),
                  ]),
                )
            ],
          ),
          ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0), // Adjust the padding as needed
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade900,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(
                      "Total   ₹ $price",
                      style: TextStyle(color: Colors.white),
                    ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white)),
                          onPressed: () async {
                            User? user = FirebaseAuth.instance.currentUser;
                            final ref = await FirebaseFirestore.instance.collection("users").doc(widget.userId).update({"items": FieldValue.arrayUnion([courseIndex])});
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(3)));
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(3))); // Replace HomePage(3) with your actual page widget);
                          },
                          child: Icon(Icons.shopping_cart,color: Colors.black,))
                    ],
                  ),
                ),
              ),
            ),
        )
    );
  }
}