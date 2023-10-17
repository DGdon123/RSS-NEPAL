import 'package:flutter/material.dart';
import 'package:rss/presentation/views/dashboard/dashboard_page.dart';

class DrawerNavigation extends StatefulWidget {
  final String? id;

  const DrawerNavigation({Key? key, this.id}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Padam Ghimire",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Row(
              children: [
                Text("padamghimire75@gmail.com"),
              ],
            ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100.0,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoardPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
