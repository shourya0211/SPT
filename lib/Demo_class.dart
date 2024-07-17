import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Demo.dart';
import 'DemoPage.dart';

class Demo extends StatefulWidget {
  String userID;
  Demo(this.userID);
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('demo_course').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.white,),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return ThumbnailCard(
                imageUrl: data['thumbnail'],
                name: data['name'],
                course: data['course'],
                userId: widget.userID,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String course;
  final String userId;

  ThumbnailCard({required this.imageUrl, required this.name, required this.course, required this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Demo1(name: name, course: course, userId: userId,)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: imageUrl == null
            ? CircularProgressIndicator(color: Colors.white,)
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(imageUrl),
                width: 200,
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
