import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


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
            appBar: AppBar(
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.black, // Set app bar background color to black
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

        
        //Shopping Page
        Text('shoppin'),
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('My Course',style: TextStyle(color: Colors.white),),
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
        Text('Profile')

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
      padding: const EdgeInsets.symmetric(horizontal: 20), // Reduce horizontal padding
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20), // Set border radius
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Reduce padding inside the container
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10), // Reduce vertical padding for image
                  child: Image(
                    image: thumbnail,
                    width: 100, // Reduce image size
                    height: 100, // Reduce image size
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), // Adjust padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseName,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Reduce font size
                        ),
                        SizedBox(height: 3), // Reduce height between text
                        Text(
                          price,
                          style: TextStyle(fontSize: 14, color: Colors.grey), // Reduce font size
                        ),
                        SizedBox(height: 3), // Reduce height between text
                        Text(
                          faculty,
                          style: TextStyle(fontSize: 14, color: Colors.grey), // Reduce font size
                        ),
                        SizedBox(height: 15), // Add space between faculty text and buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle buy button tap action here
                                // For example, you can navigate to a buy screen or perform any other action.
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set background color to green
                              ),
                              child: Text(
                                'Buy',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black, // Set font color to black
                                ),
                              ),
                            ),
                            // Add space between buttons

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  // Handle cancel icon tap action here
                  // For example, you can cancel the purchase or navigate back.
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
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

