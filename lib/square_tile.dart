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
    return Padding(
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
    );
  }
}
