import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_personal_tutor/HomePage.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class UploadProfileImage extends StatefulWidget {
  String ProfilePic;
  String userID;
  UploadProfileImage(this.ProfilePic,this.userID);
 // const UploadProfileImage({super.key});

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState(ProfilePic,userID);
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  String ProfilePic;
  String userID;
  _UploadProfileImageState(this.ProfilePic,this.userID);
  var filename ="No file Chosen";
  File? originalFile;
  Future<void>pickImag()async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: const Color.fromRGBO(50, 50, 50, 1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
            activeControlsWidgetColor: Colors.green
        ),

      ],
    );
    setState(() {
      originalFile=File(croppedFile!.path);
      if(originalFile!=null){
        String path = image!.path.toString();
        filename = path.substring(path.lastIndexOf('/') + 1);

      }
    });

  }
  Future<void>uploadImage()async{
    print(ProfilePic!);
    if(ProfilePic!=""){
      String filePath = ProfilePic
          .replaceAll(new
      RegExp(r'https://firebasestorage.googleapis.com/v0/b/scholarpersonaltutors-e5e38.appspot.com/o/'), '');
      filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
      filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
      FirebaseStorage.instance.ref().child(filePath).delete().then((e){print("Success");} );
    }
    UploadTask uploadTask=FirebaseStorage.instance.ref().child("ProfilePic").child(filename).putFile(originalFile!);
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'File Uploading...');
    uploadTask.snapshotEvents.listen((event) {
      int percentage=((event.bytesTransferred/event.totalBytes)*100).toInt();
      pd.update(value: percentage);
    });
    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();
    try{
      DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(userID);
      // Update the field
      await documentReference.update({'profilepic': downloadUrl});
      Navigator.pop(context);
    }
    catch(error){
      print(error.toString());
    }
    print(downloadUrl);
  }
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((User? user) {
    //   if (user != null) {
    //     email=user.email;
    //     print("email");
    //     print(email);
    //   }
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(50, 50, 50, 1),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Container(
          child: Column(
            children: [
              if(originalFile!=null)Container(
                child: Image.file(originalFile!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),onPressed: (){pickImag();}, child: Text("Choose File",style: TextStyle(color: Colors.black),)),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(filename,style: TextStyle(color: Colors.white)),
                    ),

                  ],
                ),
              ),
              if(originalFile!=null)Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),onPressed: (){
                    uploadImage();
                  }, child: Text("Upload",style: TextStyle(color: Colors.black),)),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
