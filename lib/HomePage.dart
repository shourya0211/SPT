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
          padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 25),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'My Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
