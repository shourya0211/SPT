import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController{
  Connectivity _connectivity=Connectivity();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _connectivity.onConnectivityChanged.listen((event) {
      if(event[0]==ConnectivityResult.none){
        Get.rawSnackbar(
            titleText: Container(
              width: double.infinity,
              height: Get.size.height*(.904),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Icon(Icons.wifi_off,size: 120,color: Colors.white,),),
                  Text("No internet connection ",style: TextStyle(fontSize: 25,color: Colors.white),)
                ],
              ),
            ),
          messageText: Container(),
          backgroundColor: Colors.black,
          isDismissible: true,
          duration: Duration(days: 1)
        );
      }
      else{
        if(Get.isSnackbarOpen){
          Get.closeCurrentSnackbar();
        }
      }
    });
  }
}