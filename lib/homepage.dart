import 'package:barangay_system_resident/dashboard.dart';
import 'package:barangay_system_resident/history.dart';
import 'package:barangay_system_resident/profile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Homepage'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
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
