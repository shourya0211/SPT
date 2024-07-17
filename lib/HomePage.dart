import 'dart:async';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:scholar_personal_tutor/Demo.dart';
import 'package:scholar_personal_tutor/EditProfile.dart';
import 'package:scholar_personal_tutor/LoginScreen.dart';
import 'package:scholar_personal_tutor/OTPVerificationScreen.dart';
import 'package:scholar_personal_tutor/OtherUserDataForGoogleAuth.dart';
import 'package:scholar_personal_tutor/OtherUserDataForPhoneAuth.dart';
import 'package:scholar_personal_tutor/PhoneNumberPage.dart';
import 'package:scholar_personal_tutor/UploadProfileImage.dart';
import 'Demo_class.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  int passData;
  HomePage(this.passData);
  @override
  State<StatefulWidget> createState() {
    return HomePageState(passData);
  }
}

class HomePageState extends State<HomePage> {
  @override
  var _razorpay = Razorpay();
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDemoCourse();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  //Code of Search Page
  List<QueryDocumentSnapshot<Object?>> allDemoCourseData = [];
  List<QueryDocumentSnapshot<Object?>> showDemoCourseData = [];
  Future<void> fetchDemoCourse() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('demo_course').get();
    var document = querySnapshot.docs;
    if (!document.isEmpty) {
      setState(() {
        allDemoCourseData = document;
        showDemoCourseData = document;
      });
    }
  }

  void runTimeFilter(String enteredKeyword) {
    List<QueryDocumentSnapshot<Object?>> result = [];
    if (enteredKeyword.isEmpty) {
      result = allDemoCourseData;
    } else {
      result = allDemoCourseData
          .where((element) => element['name']
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      showDemoCourseData = result;
    });
  }
// Code of Search Page End here
  // Code for Course start here Page
  List<Map<String, dynamic>> purchaseData = [];
  Future<void> getUserPurchaseHistory() async {
    List<Map<String, dynamic>> purchaseHistory = [];
    try {
      // Retrieve purchase order IDs of the user
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> a = userSnapshot.data() as Map<String, dynamic>;
        List<dynamic> purchaseOrderIDs = a!["purchaseCourseOrderID"];
        // Retrieve course details for each purchase order ID
        for (var orderID in purchaseOrderIDs) {
          DocumentSnapshot purchaseSnapshot = await FirebaseFirestore.instance
              .collection('purchaseCourse')
              .doc(orderID.toString())
              .get();

          if (purchaseSnapshot.exists) {
            Map<String, dynamic> b =
            purchaseSnapshot.data() as Map<String, dynamic>;
            List<dynamic> courselist = b!['purchaseCourses'];
            for (var courseID in courselist) {
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('demo_course')
                  .get();
              var document = querySnapshot.docs;
              if (!document.isEmpty) {
                Map<String, dynamic> purchase = {
                  'CourseTitle': document[int.parse(courseID)]['name'],
                  'thumbnail': document[int.parse(courseID)]['thumbnail'],
                  'date': b!['date'],
                  'name':document[int.parse(courseID)]['course']
                  // Add more details as needed
                };
                purchaseHistory.add(purchase);
              }
            }
          }
        }
      }
    } catch (e) {
      print("Error fetching purchase history: $e");
    }
    setState(() {
      purchaseData = purchaseHistory;
    });
    liveClasses();
  }

  // Code for Course Page End here

  // Code for Upcoming Video start here
  bool isLiveClassesDataLoading=true;
  List<Map<String, dynamic>> liveClassesData = [];
  Future<void> liveClasses() async{
    List<Map<String, dynamic>> b = [];
    for (var courseID in purchaseData) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('live_classes')
          .doc(courseID['name'])
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> a = userSnapshot.data() as Map<String, dynamic>;
        a['thumbnail']=courseID['thumbnail'];
        a['date']=courseID['date'];
        b.add(a);
      }
    }
    liveClassesData=b;
    setState(() {
      isLiveClassesDataLoading=false;
    });
  }
  // Code for Upcoming Video end here


  int _selectedIndex;
  HomePageState(this._selectedIndex);
  var db = FirebaseFirestore.instance;
  @override
  void dispose() {
    //_searchController.dispose(); // Dispose the controller
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  //DateTime _selectedValue = DateTime.now();
  bool isCoursePurchased = true;
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PhoneNumberPage()));
  }

  String name = "";
  String? email;
  String? course;
  String? profilePic;
  String? phoneNumber;
  bool isDataLoading = true;
  String userID = "";
  int totalPrice = 0;
  List<String> items = [];
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Fetching OrderID
    final docRef = db.collection("orderIDCounter").doc("orderID");
    docRef.get().then(
      (DocumentSnapshot doc) async {
        var data = doc.data() as Map<String, dynamic>;
        String orderID = data['orderID']; //Previous Order ID
        //Storing New Order ID in users database
        final ref = await FirebaseFirestore.instance
            .collection("users")
            .doc(userID)
            .update({
          "purchaseCourseOrderID":
              FieldValue.arrayUnion([int.parse(orderID) + 1])
        });
        //Storing data in puchase Couse database
        DateTime now = DateTime.now();
        Map<String, dynamic> purchaseCourseData = {
          "userID": userID,
          "orderID": (int.parse(orderID) + 1).toString(),
          "amount": totalPrice.toString(),
          "paymentID": response.paymentId,
          "date": now.toString(),
          "purchaseCourses": items, // Assign the list directly
        };

        db
            .collection("purchaseCourse")
            .doc((int.parse(orderID) + 1).toString())
            .set(purchaseCourseData)
            .onError((e, _) => print("Error writing document: $e"));
        //Udaitng orderIDCounter value in database
        final abc = await FirebaseFirestore.instance
            .collection("orderIDCounter")
            .doc('orderID')
            .update({"orderID": (int.parse(orderID) + 1).toString()});
        //Removing all items from cart
        final xyz = await FirebaseFirestore.instance
            .collection("users")
            .doc(userID)
            .update({"items": []});
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Success',
          desc: 'Thanks for Purchasing Courses',
          btnOkOnPress: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage(0)));
          },
        )..show();
      },
      onError: (e) => print("Error getting document: $e"),
    );
    //print(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    if(!userID.isEmpty){
      getUserPurchaseHistory();
    }
    // Checking User is LogedIn or not
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        //if user is not login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneNumberPage()));
      } else {
        //if user is login
        if (user!.email != "" && user!.email !=null) {
          //if user login with email
          final docRef = db.collection("users").doc(user!.email);
          docRef.get().then(
            (DocumentSnapshot doc) {
              var data = doc.data() as Map<String, dynamic>;
              setState(() {
                userID = data['email'];
                name = data['name'];
                email = data['email'];
                course = data['course'];
                profilePic = data['profilepic'];
                phoneNumber = data['phone'];
                items = List<String>.from(data["items"]);
              });
              //getUserPurchaseHistory();
            },
            onError: (e) => print("Error getting document: $e"),
          );
        } else {
          // if user is login with phone number
          final docRef = db.collection("users").doc(user!.phoneNumber);
          docRef.get().then(
            (DocumentSnapshot doc) {
              var data = doc.data() as Map<String, dynamic>;
              setState(() {
                userID = "+91"+data['phone'];
                name = data['name'];
                email = data['email'];
                course = data['course'];
                profilePic = data['profilepic'];
                phoneNumber = data['phone'];
                items = List<String>.from(data["items"]);
              });
              //getUserPurchaseHistory();
            },
            onError: (e) => print("Error getting document: $e"),
          );
        }
      }
    });
    Future<void> deleteCartItem(int item) async {
      try {
        // Get reference to the document
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(userID);

        // Get the current items array
        DocumentSnapshot userSnapshot = await userRef.get();
        Map<dynamic, dynamic> a = userSnapshot.data() as Map;
        List<dynamic> items = a['items'];
        // Remove the item at index 0
        items.remove(item.toString());
        // Update the document with the modified items array
        await userRef.update({'items': items});
      } catch (e) {
        print('Error deleting item: $e');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: <Widget>[
        // Home page
        name.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: Colors.white,),
              )
            : Container(
                color: Colors.black, // Set the background color to black
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Greet(),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // Assuming Greet() is a widget that displays a greeting message
                      ],
                    ),
                    backgroundColor: Colors.black,
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Carousel section
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 165, // Adjust height as needed
                                autoPlay:
                                    true, // Set to true for automatic sliding
                                enlargeCenterPage:
                                    true, // Set to true to make the centered item larger
                                aspectRatio:
                                    16 / 9, // Adjust aspect ratio as needed
                                enableInfiniteScroll:
                                    true, // Set to false to disable infinite scrolling
                              ),
                              items: [
                                // Add your carousel items here
                                // Example carousel item:
                                Image.asset('assets/images/thumbnail2.jpg',
                                    fit: BoxFit.cover),
                                Image.asset('assets/images/thumbnail1.jpg',
                                    fit: BoxFit.cover),
                                // Image.asset('assets/images/thumbnail.jpg',
                                //     fit: BoxFit.cover),
                              ],
                            ),
                            SizedBox(
                                height:
                                    15), // Add some space between carousel and other content

                            // Rest of your content
                            Text(
                              'Upcoming Live Classes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    height:
                                        220, // Adjusted height to accommodate additional content
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 205,
                                          child: isLiveClassesDataLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):liveClassesData.isEmpty?Center(child: Text("You have not purchased any course yet",style: TextStyle(color: Colors.white),),):ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                              itemCount: liveClassesData.length,
                                              itemBuilder: (context,index){
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 150,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey.shade900),
                                                        child: InkWell(
                                                            onTap: () async{
                                                              String dateTimeString=liveClassesData[index]['date'];
                                                              DateTime dateTime = DateTime.parse(dateTimeString);
                                                              DateTime currentDate = DateTime.now();
                                                              Duration difference = currentDate.difference(dateTime);
                                                              int daysRemaining = difference.inDays;

                                                              if(daysRemaining>30){
                                                                Fluttertoast.showToast(msg: "This Course Date Expire");
                                                              }
                                                              else{
                                                                final Uri _url = Uri.parse(liveClassesData[index]['class']);
                                                                if (!await launchUrl(_url)) {
                                                                  throw Exception('Could not launch $_url');
                                                                }
                                                              }

                                                            },
                                                            child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(liveClassesData[index]['thumbnail'],fit: BoxFit.cover,width: 200,height: 150,))
                                                        ),
                                                      ),
                                                      Center(child: Padding(
                                                        padding: const EdgeInsets.only(top: 10),
                                                        child: Center(child: Text("Time: "+liveClassesData[index]['time'],style: TextStyle(color: Colors.white,fontSize: 18),)),
                                                      ),)
                                                    ],
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        //SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Demo Classes',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Demo(userID),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

        // Search page
        // Scaffold(
        //   backgroundColor: Colors.black,
        //   appBar: AppBar(
        //     iconTheme: IconThemeData(color: Colors.white),
        //     backgroundColor: Colors.black,
        //   ),
        //   body: ,
        // ),
        allDemoCourseData!.isEmpty
            ? Center(
          child: CircularProgressIndicator( color: Colors.white,),
        )
            : Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Column(
                        children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    onChanged: (value) => runTimeFilter(value),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        focusColor: Colors.white,
                        hintText: "Search Course here...",
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: Icon(Icons.search),
                        suffixIconColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(demoCourseData.length.toString(),style: TextStyle(color: Colors.white),),
              Expanded(
                child: ListView.builder(
                    itemCount: showDemoCourseData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 3),
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.book,
                              color: Colors.white,
                            ),
                            title: Text(
                              showDemoCourseData[index]['name'],
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Demo1(
                                          name: showDemoCourseData[index]
                                          ['name'],
                                          course:
                                          showDemoCourseData[index]
                                          ['course'],
                                          userId: userID)));
                            },
                          ),
                        ),
                      );
                    }),
              ),
                        ],
                      ),
            ),


        // Course page
        CoursePage(purchaseData: purchaseData),

        //Shopping Page
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title:const Text(
              'Cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: name.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                )
              : items.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/emptyCart.png",
                        color: Colors.grey.shade700,
                        height: 150,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity,
                                      minHeight: 56.0),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("demo_course")
                                        .snapshots(),
                                    builder: (context, myData) {
                                      if (myData.hasData) {
                                        var document = myData.data!.docs;
                                        totalPrice = 0;
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: items.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              int p = int.parse(document[
                                                      int.parse(items[index])]
                                                  ['price']);
                                              totalPrice += p;
                                              // print(document[index]
                                              // ['thumbnail']));
                                              return CourseInfo(
                                                thumbnail: NetworkImage(
                                                    document[
                                                    int.parse(items[index])]
                                                        ['thumbnail']),
                                                courseName: document[
                                                        int.parse(items[index])]
                                                    ['name'],
                                                price: document[
                                                        int.parse(items[index])]
                                                    ['price'],
                                                faculty: document[
                                                        int.parse(items[index])]
                                                    ['faculty'],
                                                onTap: () {
                                                  deleteCartItem(
                                                      int.parse(items[index]));
                                                },
                                              );
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(color: Colors.white,),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                  children: [items.isEmpty?Text("Price   ₹0", style: TextStyle(color: Colors.white),):
                    Text(
                      "Price ₹$totalPrice",
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white)),
                        onPressed: () async {
                          print(totalPrice);
                          var options = {
                            'key': 'rzp_test_nCdl84G8xQKpgR',
                            'amount': totalPrice *
                                100, //in the smallest currency sub-unit.
                            'name': 'Scholar Personal Tutor',
                            //'order_id': '13q24234', // Generate order_id using Orders API
                            'timeout': 10 * 60, // in seconds
                            // 'prefill': {
                            //   'contact': '9000090000',
                            //   'email': 'gaurav.kumar@example.com'
                            // }
                          };
                          if(!items.isEmpty){
                            _razorpay.open(options);
                          }
                          else{
                            Fluttertoast.showToast(msg: "Cart is Empty.");
                          }

                        },
                        child: Text(
                          "Buy",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),

        //Profile page
        name.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: Colors.white,),
              )
            : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        // Profile Picture and Text Row
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      profilePic != ""
                                          ?ClipRRect(borderRadius: BorderRadius.circular(50.0),child: CachedNetworkImage(width: 100,height: 100,imageUrl: profilePic!,placeholder: (context,url)=>Center(child: CircularProgressIndicator(color: Colors.white,)),))
                                          : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: AssetImage(
                                            "assets/images/profileDemoImage.jpg"),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                          right: 0,
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => UploadProfileImage(profilePic!,userID)));
                                            },
                                              child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Container(color: Colors.white,height: 30,width: 30,child: Icon(Icons.edit,color: Colors.black,))))
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              // for name
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade900
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.perm_identity,color: Colors.white,size: 30,),
                                    ),
                                    Text(name!,style: TextStyle(color: Colors.white,fontSize: 18),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),

                              //for email

                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade900
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.email,color: Colors.white,size: 30,),
                                    ),
                                    Text(email!,style: TextStyle(color: Colors.white,fontSize: 18),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),

                              // for Conract number

                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade900
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.phone,color: Colors.white,size: 30,),
                                    ),
                                    Text(phoneNumber!,style: TextStyle(color: Colors.white,fontSize: 18),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),

                              // For Courses

                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.shade900
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.book,color: Colors.white,size: 30,),
                                    ),
                                    Text(course!,style: TextStyle(color: Colors.white,fontSize: 18),),
                                  ],
                                ),
                              ),
                              //SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                if(userID==email){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(userID,"email",course!,phoneNumber!)));
                                }
                                else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(userID,"phone",course!,phoneNumber!)));
                                }

                              },
                              icon: const Icon(Icons.edit,color: Colors.black,),
                              label: const Text(
                                'Edit Profile',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Change button color to green
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                logout();
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .white, // Change the button color to green
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ),
      ][_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = false,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.2),
      child: ListTile(
        tileColor: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onTap: onPress,
        leading: Container(
          width: 10,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black12,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title,
            style:
                const TextStyle(color: Colors.white).apply(color: textColor)),
        trailing: endIcon
            ? Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
// for course

class CourseInfo extends StatelessWidget {
  final ImageProvider thumbnail;
  final String courseName;
  final String price;
  final String faculty;
  final Function()? onTap;

  CourseInfo(
      {required this.thumbnail,
      required this.courseName,
      required this.price,
      required this.faculty,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 7, horizontal: 10), // Adjusted padding
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120, // Increased width of the image
                  height: 90, // Increased height of the image
                  child: Image(
                    fit: BoxFit.cover,
                    image: thumbnail, // Adjusted to cover the container
                  ),
                ),
                SizedBox(width: 20), // Add space between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseName,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        faculty,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "₹$price",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10), // Add space between text and button
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                onPressed: onTap,
                icon: Icon(Icons.cancel, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoInfo extends StatelessWidget {
  final String thumbnailPath;
  final String courseName;

  DemoInfo({
    required this.thumbnailPath,
    required this.courseName,

    // Rename this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 7, horizontal: 10), // Adjusted padding
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0), // Adjusted padding
                  child: Image.asset(
                    thumbnailPath,
                    width: 120, // Increased width of the image
                    height: 90, // Increased height of the image
                    fit: BoxFit.cover, // Adjusted to cover the container
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Video player screen widget

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color:
            Colors.black, // Set background color of the bottom navigation bar
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.search, 'Search', 1),
          _buildNavItem(Icons.menu_book_outlined, 'Course', 2),
          _buildNavItem(Icons.shopping_cart_rounded, 'Cart', 3),
          _buildNavItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 50,
        padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 2.0), // Adjusted padding for smaller size
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Colors
                  .transparent, // Change background color based on selection
          borderRadius: BorderRadius.circular(12.0), // Adjusted border radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white.withOpacity(0.5),
            ),
            SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color:
                    isSelected ? Colors.black : Colors.white.withOpacity(0.5),
                fontSize: 10, // Adjusted font size for smaller size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Greet extends StatelessWidget {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning,';
    } else if (hour < 17) {
      return 'Good afternoon,';
    } else {
      return 'Good evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          greeting(),
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}

Widget _buildPurchasedCourseListView() {
  final List<String> liveVideoThumbnails = [
    'assets/images/thumbnail.jpg', // Replace with your image paths

    // Add more image paths as needed
  ];

  final List<String> liveVideoTimeSlots = [
    '11:20',
  ];
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: liveVideoThumbnails.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    liveVideoThumbnails[index],
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Time Slot: ${liveVideoTimeSlots[index]}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class CoursePage extends StatefulWidget {
  List<Map<String, dynamic>> purchaseData;
  CoursePage({required this.purchaseData});

  @override
  State<CoursePage> createState() => _CoursePageState(purchaseData);
}

class _CoursePageState extends State<CoursePage> {
  List<Map<String, dynamic>> purchaseData;
  _CoursePageState(this.purchaseData);

  @override
  Widget build(BuildContext context) {
    //getUserPurchaseHistory();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'My Course',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: purchaseData.isEmpty
          ? Center(
              child: Text("You have not purchased any course yet",style: TextStyle(color: Colors.white),),
            )
          : GridView.builder(
              itemCount: purchaseData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9/10,
                  crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                String dateTimeString = purchaseData[index]['date'];
                DateTime dateTime = DateTime.parse(dateTimeString);
                String dateToString = dateTime.toString().split(" ")[0];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            child: CachedNetworkImage(
                                imageUrl: purchaseData[index]['thumbnail']),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Text(
                            purchaseData[index]['CourseTitle'],
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        Text(
                          dateToString,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

class TimingsPage extends StatelessWidget {
  const TimingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Timings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300, // Adjust height of the hourglass image
              child: Image.asset(
                "assets/images/rotating_hourglass.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'TIMING',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '30 days left for subscription',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for DOWNLOAD BILL button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Set background color to green
                    minimumSize: Size(150, 50), // Set minimum button size
                  ),
                  child: const Text(
                    'DOWNLOAD BILL',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20), // Add space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Functionality for Course Material button
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => PdfViewerPage()), // Navigate to PdfViewerPage
                    // )
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Set background color to green
                    minimumSize: Size(150, 50), // Set minimum button size
                  ),
                  child: const Text(
                    'COURSE MATERIAL',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for RENEW NOW button
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set background color to green
                minimumSize: Size(150, 50), // Set minimum button size
              ),
              child: const Text(
                'RENEW NOW',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCourseContainer(BuildContext context, Color color) {
  return Container(
    margin: const EdgeInsets.all(10), // Add margin between containers
    padding: const EdgeInsets.all(20), // Add padding inside containers
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20), // Add rounded corners
      color: color,
    ),
    width: MediaQuery.of(context).size.width * 0.7, // Set width as needed
    child: Column(
      children: [
        Image.asset(
          "assets/images/thumbnail.jpg",
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Course Name",
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
        )
      ],
    ),
  );
}
