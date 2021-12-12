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
  List data = [];
  Widget listItem({title, leading = Icons.label, subtitle}) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(leading),
        ),
      ],
    );
  }

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
          Profile.birthdate = data['birthdate'].toString();
          Profile.birthplace = data['birthplace'];
          Profile.civil_status = data['civil_status'];
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: const BoxDecoration(
                      color: Color(0xff075E54),
                      border: Border(
                          bottom: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ))),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipOval(
                                child: Image.network(
                              data['resident_img_url'],
                              width: 150,
                            )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  data['first_name'] +
                                      " " +
                                      data['middle_name'] +
                                      " " +
                                      data['last_name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                Text(
                                  data['email'],
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['gender'],
                  leading: Icons.male,
                  subtitle: "Gender",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['civil_status'],
                  leading: Icons.male,
                  subtitle: "Civil Status",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['age'],
                  leading: Icons.person,
                  subtitle: "Age",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['birthdate'].toString(),
                  leading: Icons.cake,
                  subtitle: "Birth Date",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['birthplace'],
                  leading: Icons.location_city,
                  subtitle: "Birth Place",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['phone_number'],
                  leading: Icons.phone,
                  subtitle: "Phone Number",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['street'],
                  leading: Icons.add_road,
                  subtitle: "Street",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['purok'],
                  leading: Icons.add_location_alt_outlined,
                  subtitle: "Purok",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['citizenship'],
                  leading: Icons.book,
                  subtitle: "Citizenship",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['diff_disabled'],
                  leading: Icons.accessible_rounded,
                  subtitle: "Differently Disabled",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['relation'],
                  leading: Icons.account_balance,
                  subtitle: "Relation to Head Famly",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                listItem(
                  title: data['religion'],
                  leading: Icons.add,
                  subtitle: "Religion",
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
              ],
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
