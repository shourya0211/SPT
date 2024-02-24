import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white10,
      backgroundColor: Colors.black.withOpacity(1.0),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "test_name",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/images.jpg"),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                    image: AssetImage('assets/images/home_page_bg.webp'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 35,
            ),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => print('profile tapped'),
          ),
          ListTile(
            leading: Icon(
              Icons.badge_outlined,
              color: Colors.white,
              size: 35,
            ),
            title: Text('Batch', style: TextStyle(color: Colors.white)),
            onTap: () {
              print("batch tapped");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.circle_notifications_outlined,
              color: Colors.white,
              size: 35,
            ),
            title: Text('Notifications', style: TextStyle(color: Colors.white)),
            onTap: () => print('notifications tapped'),
          ),
          Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 35,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => print('settings tapped'),
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.white,
              size: 35,
            ),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () => print('logout tapped'),
          ),
        ],
      ),
    );
  }
}
