import 'package:barangay_system_resident/dashboard.dart';
import 'package:barangay_system_resident/history.dart';
import 'package:barangay_system_resident/login.dart';
import 'package:barangay_system_resident/profile.dart';
import 'package:barangay_system_resident/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fluttertoast/fluttertoast.dart';

int total_certificates = 0;

final NewPasswordController = TextEditingController();
final ConfirmNewPasswordController = TextEditingController();
final OldPasswordController = TextEditingController();

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  static String OldPassword = "";

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference currentUserCollectionRef =
      FirebaseFirestore.instance.collection('resident_list');
  Future<void> updateUser() {
    return currentUserCollectionRef
        .doc(currentUser?.uid)
        .update({'status': 'Offline'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> handleClick(int item, BuildContext context) async {
    switch (item) {
      case 1:
        {
          showChangePassModal();
          break;
        }
      case 2:
        {
          await FirebaseAuth.instance.signOut();
          updateUser();
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          break;
        }

      case 2:
        break;
    }
  }

  Future<void> showChangePassModal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: OldPasswordController,
                  onChanged: (value) {},
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Old Password",
                      hintText: "Old Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                TextFormField(
                  controller: NewPasswordController,
                  onChanged: (value) {},
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "New Password",
                      hintText: "New Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                TextFormField(
                  controller: ConfirmNewPasswordController,
                  onChanged: (value) {},
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Confirm New Password",
                      hintText: "Confirm New Password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                ConfirmNewPasswordController.text = "";
                NewPasswordController.text = "";
                OldPasswordController.text = "";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                if (ConfirmNewPasswordController.text ==
                    NewPasswordController.text) {
                  if (Homepage.OldPassword == OldPasswordController.text) {
                    _changePassword(ConfirmNewPasswordController.text);
                  } else {
                    Fluttertoast.showToast(
                      msg: "Old Password is Incorrect!",
                      toastLength: Toast.LENGTH_SHORT,
                      fontSize: 18,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "New Password And Confirm Password Not Match!",
                    toastLength: Toast.LENGTH_SHORT,
                    fontSize: 18,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    var user = FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user?.updatePassword(password).then((_) {
      Fluttertoast.showToast(
        msg: "Successfully changed password",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 18,
      );
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Password can't be changed" + error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 18,
      );
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  void initState() {
    super.initState();
    total_certificates = 0;
    // START OF GETTING TOTAL NUMBER OF NOTIFICATIONS
    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_residency')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_blotter')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_building')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_clearance')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_excavation')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_fencing')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_indigent')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_water')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_wiring')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_business')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          total_certificates++;
        });
      });
    });
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
                  notificationCount:
                      total_certificates), //Place how many new notification
              PopupMenuButton<int>(
                onSelected: (item) => handleClick(item, context),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text('Change Password'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
            backgroundColor: Colors.green,
            // flexibleSpace: Container(
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           colors: [Color(0xff20bf55), Color(0xff01baef)],
            //           begin: Alignment.topLeft)),
            // ),
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
