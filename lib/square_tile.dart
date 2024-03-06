import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String text;
  const SquareTile({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: Image.asset(imagePath),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
InkWell(
onTap: () {
// Add your functionality here
},
borderRadius: BorderRadius.circular(16),
child: Container(
height: 56,
padding: EdgeInsets.all(20),
decoration: BoxDecoration(
border: Border.all(color: Colors.black),
borderRadius: BorderRadius.circular(30),
color: Colors.grey[200],
),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
SizedBox(
width: 46,
height: 50,// Adjust the width of the image
child: Image.asset(
imagePath,
height: 46,
),
),
SizedBox(width: 10), // Adjust the spacing between image and text
SizedBox(
width: 180,
height: 40,// Adjust the width of the text
child: Text(
text,
style: TextStyle(
fontSize: 13,
fontWeight: FontWeight.bold,
),
),
),
],
),
),
)*/