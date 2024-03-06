import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scholar_personal_tutor/VideoPlayerScreen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';




class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();




  List<String> suggestions = [
    'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Pineapple',
    'Watermelon',
    'Mango',
  ];

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller
    super.dispose();
  }
  void _updateSuggestions(String input) {
    setState(() {
      suggestions = input.isEmpty
          ? [
        'Apple',
        'Banana',
        'Orange',
        'Grapes',
        'Pineapple',
        'Watermelon',
        'Mango',
      ]
          : suggestions
          .where((suggestion) =>
          suggestion.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  void _clearTextField() {
    _searchController.clear();
    _updateSuggestions('');
  }

  void _navigateToSuggestionDetail(String suggestion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        //change here for show screen on search
        builder: (context) => VideoPlayerScreen(videoUrl: 'xyz.com', Description: 'hello', Title: 'demo'),
      ),
    );
  }
  final List<String> liveVideoThumbnails = [
    'assets/images/thumbnail.jpg', // Replace with your image paths

    // Add more image paths as needed
  ];

  final List<String> VideoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  final List<String> Description = [
    'Machine learning, the art of teaching computers to learn and adapt from data, is not just a powerful tool of today but also a glimpse into the future. As we explore its concepts and applications, it is important to understand that machine learning’s influence will only grow. In the coming years, it will play a pivotal role in reshaping industries, automating tasks, and unlocking new frontiers of innovation, making our world smarter and more efficient.',
    'BASICS OF PROGRAMMING LANGUAGE OOPS,PATTERN QUESTION TIME AND SPACE COMPLEXITY DIVING INTO DSA WITH ARRAYS, STRINGS COLLECTION FRAMEWORK ,RECURSION AND OOPS HASHMAP & HASHSET ,BINARY TREES & TRIE GRAPHS ,DYNAMIC PROGRAMMING BACK TRACKING SEGMENT TREES',
    'Botany,Zoology,Organic-Chemistry,Physical-Chemistry,Inorganic-Chemistry,Physics ',
    'Maths,Organic-Chemistry,Physical-Chemistry,Inorganic-Chemistry,Physics',
    'HTML,CSS,Java Script,DOM,Responsive Web Design,Web Hosting and Deployment,Final Project'


  ];

  final List<String> liveVideoTimeSlots =[
    '11:20',


  ];


  final List<String> liveVideoTitles = [
    'Live Video 1',

    // Add your live video titles here
  ];

  final List<String> demoVideoThumbnails = [
    'assets/images/thumbnail.jpg', // Replace with your image paths
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',
    'assets/images/thumbnail.jpg',

  ];


  final List<String> demoVideoTitles = [
    'Machine Learning',
    'Competitive Programing',
    'NEET',
    'IITJEE',
    'Website Development'
    // Add your demo video titles here
  ];


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  DateTime _selectedValue = DateTime.now();
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
                        SizedBox(height: 15 ), // Add some space between carousel and other content
              
                        // Rest of your content
                        Text(
                          'My Classes',
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
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                                  ),
                                  height: 88,
                                  child: DatePicker(
                                    DateTime.now(),
                                    initialSelectedDate: DateTime.now(),
                                    selectionColor: Colors.black,
                                    selectedTextColor: Colors.white,
                                    onDateChange: (date) {
                                      // New date selected
                                      setState(() {
                                        _selectedValue = date;
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(height: 10),

                                Container(
                                  height: 243, // Adjusted height to accommodate additional content
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'Upcoming Live Videos', // Assuming this is the title of the section
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: ListView.builder(
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
                                                    'Time Slot: ${liveVideoTimeSlots[index]}', // Assuming liveVideoTimeSlots is a list containing time slots
                                                    style: TextStyle(
                                                      fontSize: 12,
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
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Add your logic for joining the class here
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green, // Set the background color to green
                                            ),
                                            child: Text(
                                              'Join Class',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),


                              ],
                            ),
                        ),


                        SizedBox(height: 5),
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
                            Container(
              
              
                              height: 155, // Set the height of the horizontal scrollable list
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal, // Change scroll direction to horizontal
                                itemCount: demoVideoThumbnails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3),
                                  child: GestureDetector(
                                  onTap: () {
                                  // Navigate to the video player screen when tapped
                                  Navigator.push(
                                      context,
                                    MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                    videoUrl: VideoUrls[index],
                                    Description: Description[index],
                                      Title: demoVideoTitles[index],
                                        ),
                                      ),
                                    );
                                  },
              
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
              
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                                              child: Image.asset(
                                                  demoVideoThumbnails[index],
                                                width: 150,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          demoVideoTitles[index],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
              
                                          ),
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
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return suggestions.where((suggestion) =>
                          suggestion.toLowerCase().contains(
                              textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (String selectedValue) {
                      setState(() {
                        _searchController.text = selectedValue;
                      });
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        onChanged: _updateSuggestions,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          prefixIcon: const IconButton(
                              icon: Icon(Icons.search), onPressed: null),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearTextField,
                            color: Colors.black,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white70,
                          elevation: 0.0,
                          child: SizedBox(
                            height: 400,
                            width: 370,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(),
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                    _navigateToSuggestionDetail(option); // Navigate to detail page
                                  },
                                  child: ListTile(
                                    title: Text(option),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
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
                      'IITJEE',
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
                      'NEET',
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
                      'Website Development',
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
                      'Competitive Programing',
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
          padding: const EdgeInsets.symmetric(vertical:40),
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
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Text(
                          'User',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // You can add additional text or widgets here
                    const Text(
                      'Additional Info',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 0.7,),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'State',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic to handle edit profile button tap
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile',style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Change button color to green
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic to handle logout button tap
                    },
                    icon: const Icon(Icons.logout,color: Colors.white,),
                    label: const Text('Logout',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change the button color to green
                    ),
                  ),
                ],
              ),

            ],
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



  DemoInfo({
    required this.thumbnailPath,
    required this.courseName,

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


