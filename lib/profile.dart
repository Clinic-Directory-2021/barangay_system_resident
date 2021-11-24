import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  static String first_name = "";
  static String middle_name = "";
  static String last_name = "";
  static String gender = "";
  static String profilePic = "";
  static String email = "";

  static String age = "";
  static String birthdate = "";
  static String birthplace = "";
  static String civil_status = "";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var currentUser = FirebaseAuth.instance.currentUser;

  // fetchData() {
  //   DocumentReference documentReference = FirebaseFirestore.instance
  //       .collection('resident_list')
  //       .doc('VCHXn9yWFmgOiOf85eIQmr9ofMy2');

  //   documentReference.snapshots().listen((snapshot) {
  //     setState(() {
  //       last_name = snapshot['last_name'];
  //     });
  //   });
  // }
  CollectionReference users =
      FirebaseFirestore.instance.collection('resident_list');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          // return Text("Full Name: ${data['first_name']} ${data['last_name']}");
          Profile.first_name = data['first_name'];
          Profile.middle_name = data['middle_name'];
          Profile.last_name = data['last_name'];
          Profile.gender = data['gender'];
          Profile.profilePic = data['resident_img_url'];
          Profile.email = data['email'];

          Profile.age = data['age'];
          Profile.birthdate = data['birthdate'];
          Profile.birthplace = data['birthplace'];
          Profile.civil_status = data['civil_status'];
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      // Text(
                      //   "Sign Up",
                      //   style: TextStyle(
                      //       fontSize: 30, fontWeight: FontWeight.bold),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Text(
                      //   "Create an account, It's Free ",
                      //   style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      textfield(
                          hintText: data['first_name'], icon: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['middle_name'],
                          icon: Icons.account_box_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['last_name'], icon: Icons.account_box),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(hintText: data['email']),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(hintText: data['gender'], icon: Icons.male),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['civil_status'],
                          icon: Icons.add_location),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['age'],
                          icon: Icons.assignment_ind_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(hintText: data['birthdate'], icon: Icons.cake),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['phone_number'], icon: Icons.ad_units),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['birthplace'],
                          icon: Icons.add_location_alt_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(hintText: data['street'], icon: Icons.add_road),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['purok'],
                          icon: Icons.add_location_alt_outlined),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['citizenship'], icon: Icons.book),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['diff_disabled'],
                          icon: Icons.accessible_rounded),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(
                          hintText: data['relation'],
                          icon: Icons.account_balance),
                      SizedBox(
                        height: 20,
                      ),
                      textfield(hintText: data['religion'], icon: Icons.add),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}

//textfield in profile

Widget textfield({required String hintText, icon = Icons.email}) {
  return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
        ),
      ));
}
