import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scholar_personal_tutor/VideoPlayerScreen.dart';


import 'NavBar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final List<String> liveVideoThumbnails = [
    'assets/images/thumbnail.jpg', // Replace with your image paths
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',
    // Add more image paths as needed
  ];

  final List<String> liveVideoTitles = [
    'Live Video 1',
    'Live Video 2',
    'Live Video 3',
    // Add your live video titles here
  ];

  final List<String> demoVideoThumbnails = [
    'assets/images/thumbnail.jpg', // Replace with your image paths
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',
  ];

  final List<String> demoVideoTitles = [
    'Demo Video 1',
    'Demo Video 2',
    'Demo Video 3',
    'Demo Video 2',
    // Add your demo video titles here
  ];


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:<Widget>[
        // Home page

        Container(
          color: Colors.black, // Set the background color to black
          child: Scaffold(
            appBar : AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Greet(),


                  Text(
                    'Rohit Sharma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                  ),// Assuming Greet() is a widget that displays a greeting message
                ],
              ),
              backgroundColor: Colors.black,
            ),


            body: Container(
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Carousel section
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200, // Adjust height as needed
                          autoPlay: true, // Set to true for automatic sliding
                          enlargeCenterPage: true, // Set to true to make the centered item larger
                          aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                          enableInfiniteScroll: true, // Set to false to disable infinite scrolling
                        ),
                        items: [
                          // Add your carousel items here
                          // Example carousel item:
                          Image.asset('assets/images/thumbnail.jpg', fit: BoxFit.cover),
                          Image.asset('assets/images/thumbnail.jpg', fit: BoxFit.cover),
                          Image.asset('assets/images/thumbnail.jpg', fit: BoxFit.cover),
                        ],
                      ),
                      SizedBox(height: 20), // Add some space between carousel and other content

                      // Rest of your content
                      Text(
                        'Live Classes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 160, // Set the height of the horizontal scrollable list
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: liveVideoThumbnails.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                                        child: Image.asset(
                                          liveVideoThumbnails[index],
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    liveVideoTitles[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
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
                          Container(
                            height: 412, // Set the height of the horizontal scrollable list
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: demoVideoThumbnails.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoPlayerScreen(videoUrl:  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DemoInfo(
                                          thumbnailPath: demoVideoThumbnails[index],
                                          courseName: 'course',
                                          faculty: 'xyz sir',
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 32),
          child: Container(
            width: 300, // Adjust width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Set border radius
              border: Border.all(
                color: Colors.white, // Set border color
                width: 2, // Set border width
              ),
              color: Colors.white, // Set background color of the search bar
            ),
            child: Row( // Row to align search icon and text field
              children: [
                Padding( // Padding for the search icon
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black, // Set icon color
                  ),
                ),
                Expanded( // Expanded widget to allow the text field to take remaining space
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none, // Hide default border
                      contentPadding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
                    ),
                    style: TextStyle(
                      color: Colors.black, // Set text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),



        // Course page
        Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
                'Course',
            style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
        ),
      ),
      ),
    body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          // Add images here
          // Example image widget


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Add border radius
              child: Stack(
                children: [
                  Image.asset('assets/images/thumbnail.jpg'),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, // Start the gradient closer to the top
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white30.withOpacity(0.030), // Adjust opacity of white color
                            Colors.black12.withOpacity(1), // Adjust opacity of black color
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 10,
                    child: Text(
                      'Machine Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Add border radius
              child: Stack(
                children: [
                  Image.asset('assets/images/thumbnail.jpg'),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, // Start the gradient closer to the top
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white30.withOpacity(0.030), // Adjust opacity of white color
                            Colors.grey.shade900.withOpacity(1), // Adjust opacity of black color
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 10,
                    child: Text(
                      'Machine Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Add border radius
              child: Stack(
                children: [
                  Image.asset('assets/images/thumbnail.jpg'),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter, // Start the gradient closer to the top
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white30.withOpacity(0.030), // Adjust opacity of white color
                            Colors.black12.withOpacity(1), // Adjust opacity of black color
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 10,
                    child: Text(
                      'Machine Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ),



        ],


      ),
    ),




    //Shopping Page

        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Cart',style: TextStyle(color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,),),
          ),
          body:Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course Name',
                    price: '\₹99.99',
                    faculty: 'by xyz sir',
                  ),
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course 1',
                    price: '\₹80',
                    faculty: 'by pos sir',
                  ),
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course 1',
                    price: '\₹80',
                    faculty: 'by pos sir',
                  ),
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course 1',
                    price: '\₹80',
                    faculty: 'by pos sir',
                  ),
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course 1',
                    price: '\₹80',
                    faculty: 'by pos sir',
                  ),
                  SizedBox(height: 10),
                  CourseInfo(
                    thumbnail: AssetImage('assets/images/thumbnail.jpg'),
                    courseName: 'Course 1',
                    price: '\₹80',
                    faculty: 'by pos sir',
                  ),
                ],

              ),
            ),
          ),
        ),





        //Profile page
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Text('Profile',style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold)           ),
              // Profile Picture and Text Row
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey, // You can change this to an actual profile picture
                      ),
                      // You can replace the placeholder text with actual user's name
                      child:const  Center(
                        child: Text(
                          'User',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Add some space between profile picture and text
                    // You can add additional text or widgets here
                    const Text(
                      'Additional Info',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Container(

                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        //SizedBox(
                        //     width: 120,height:120,
                        //     child:ClipRRect(borderRadius: BorderRadius.circular(100), child: Image.asset('profile.jpg'))
                        // ),

                        const Divider(thickness:1.0, color: Colors.white,),
                        const SizedBox(height:50),
                        //menu
                        ProfileMenuWidget(title: "Settings",icon: Icons.settings_outlined,onPress: (){},),
                        const SizedBox(height: 5), // Add some gap between tiles
                        const Divider(height:0, color: Colors.transparent), // Add some gap between tiles
                        const SizedBox(height: 10), // Add some gap between tiles

                        ProfileMenuWidget(title: "2",icon: Icons.settings_outlined, textColor:Colors.white,onPress: (){},),
                        const SizedBox(height: 10), // Add some gap between tiles
                        const Divider(height: 0, color: Colors.transparent), // Add some gap between tiles
                        const SizedBox(height: 10), // Add some gap between tiles

                        ProfileMenuWidget(title: '3',icon: Icons.settings_outlined,onPress: (){},),
                        const SizedBox(height: 10), // Add some gap between tiles
                        const Divider(height: 0, color: Colors.transparent), // Add some gap between tiles
                        const SizedBox(height: 10), // Add some gap between tiles

                        ProfileMenuWidget(title: '4',icon: Icons.settings_outlined,onPress: (){},),
                        const SizedBox(height: 10), // Add some gap between tiles
                        const Divider(height: 0, color: Colors.transparent), // Add some gap between tiles
                        const SizedBox(height: 10), // Add some gap between tiles

                        /* ProfileMenuWidget(title: '5',icon: Icons.settings_outlined,onPress: (){},),
                        const SizedBox(height: 10), // Add some gap between tiles
                        const Divider(height: 0, color: Colors.transparent), // Add some gap between tiles
                        const SizedBox(height: 10), // Add some gap between tiles*/

                        // Bottom Icons Row
                        Container(
                          color: Colors.black,
                          child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Perform some function when tapped
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.edit_outlined),
                                      SizedBox(width: 5),
                                      Text('Edit Profile',style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {// Perform some function when tapped
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,

                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.logout_outlined),
                                      SizedBox(width: 5),
                                      Text('Logout'),
                                    ],

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )],),
        )

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
    this.endIcon= false,
    this.textColor,

  })  : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:0.2),
      child: ListTile(
        tileColor: Colors.white10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onTap: onPress,
        leading: Container(
          width: 10,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:Colors.black12,
          ),
          child: Icon(icon,color: Colors.white,),
        ),
        title: Text(title,style: const TextStyle(color: Colors.white).apply(color:textColor)),
        trailing:endIcon? Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color:Colors.black,
          ),
          child: const Icon(Icons.arrow_forward_rounded,color: Colors.white, ),
        ):null,

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

  CourseInfo({
    required this.thumbnail,
    required this.courseName,
    required this.price,
    required this.faculty,
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
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10), // Adjusted padding
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 3),
                      Text(
                        faculty,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 10), // Add space between text and button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle buy button tap action here
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set background color to green
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0), // Set rounded corner radius
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Buy',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                onPressed: () {
                  // Handle cancel button tap action here
                },
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
  final String faculty;


  DemoInfo({
    required this.thumbnailPath,
    required this.courseName,
    required this.faculty,
     // Rename this parameter
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10), // Adjusted padding
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
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 3),
                        Text(
                          faculty,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
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
        color: Colors.black, // Set background color of the bottom navigation bar
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
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0), // Adjusted padding for smaller size
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent, // Change background color based on selection
          borderRadius: BorderRadius.circular(12.0), // Adjusted border radius
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
            ),
            SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
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
        Text(greeting(),style: TextStyle(fontSize: 20,
          fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    );

  }
}


