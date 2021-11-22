import 'package:barangay_system_resident/dashboard.dart';
import 'package:barangay_system_resident/history.dart';
import 'package:barangay_system_resident/login.dart';
import 'package:barangay_system_resident/profile.dart';
import 'package:barangay_system_resident/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {

  Future<void> handleClick(int item, BuildContext context) async {
    switch (item) {
      case 1:
        {
          await FirebaseAuth.instance.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          break;
        }

      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Homepage'),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              NamedIcon(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  iconData: Icons.notifications,
                  notificationCount: 11), //Place how many new notification
              PopupMenuButton<int>(
                onSelected: (item) => handleClick(item, context),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff20bf55), Color(0xff01baef)],
                      begin: Alignment.topLeft)),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Dashboard',
                ),
                Tab(
                  icon: Icon(Icons.face),
                  text: 'Profile',
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: 'History',
                )
              ],
            ),
            elevation: 10,
            titleSpacing: 0,
          ),
          body: TabBarView(children: [
            buildPage('Dashboard', context),
            buildPage('Profile', context),
            buildPage('History', context),
          ]),
          backgroundColor: Color(0xffdcdcdc),
        ),
        length: 3,
      );

  Widget buildPage(String text, BuildContext context) {
    switch (text) {
      case "Dashboard":
        {
          return Dashboard();
        }
      case "Profile":
        {
          return Profile();
        }
      case "History":
        {
          return History();
        }
      default:
        {
          return Center(
            child: Text("No return"),
          );
        }
    }
  }
}

class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text('$notificationCount'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
