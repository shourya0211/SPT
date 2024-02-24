import 'dart:ui';

import 'package:flutter/material.dart';

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
  ];

  final List<String> demoVideoTitles = [
    'Demo Video 1',
    'Demo Video 2',
    'Demo Video 3',
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

    Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                child: SizedBox(
                  height: 160,
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
              ),
              SizedBox(height: 20), // Add some space between live and demo classes
              Text(
                'Demo Classes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: demoVideoThumbnails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25), // Adjust the radius value as needed
                                child: Image.asset(
                                  demoVideoThumbnails[index],
                                  width: double.infinity,
                                  height: 200, // Set the desired height of the image
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            demoVideoTitles[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
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



        // Shopping page
        Text('TShopping'),
        
        //Course Page
        Text('Course'),
        
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

