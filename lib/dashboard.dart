import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:barangay_system_resident/profile.dart';

bool shouldDisplay = false;
final puposeController = TextEditingController();

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference collection_ref =
        FirebaseFirestore.instance.collection('certificate_requests');

    Future<void> addRequests() {
      String epochTime = DateTime.now().millisecondsSinceEpoch.toString();
      // Call the user's CollectionReference to add a new user
      return collection_ref
          .doc(epochTime)
          .set({
            'certificate_type': value,
            'request_id': epochTime,
            'first_name': Profile.first_name,
            'middle_name': Profile.middle_name,
            'last_name': Profile.last_name,
            'gender': Profile.gender,
            'resident_img_url': Profile.profilePic,
            'email': Profile.email,
            'resident_id': currentUser?.uid,
            'status': 'Pending',
            'age': Profile.age,
            'birthdate': Profile.birthdate,
            'birthplace': Profile.birthplace,
            'civil_status': Profile.civil_status,
            'purpose': puposeController.text,
          })
          .then((value) => print("Request Added"))
          .catchError((error) => print("Failed to add Request: $error"));
    }

    return Center(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                'Select certificate you want to issue:',
                style: TextStyle(fontSize: 18, fontFamily: 'Calibri'),
              )),
          Container(
              margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white),
              child: DropdownButtonFormField<String>(
                value: value,
                decoration: InputDecoration(prefixIcon: Icon(Icons.article)),
                iconSize: 36,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                hint: Text("Select certificate"),
                style: TextStyle(color: Colors.black),
                isExpanded: true,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (dropdownValue) {
                  setState(() {
                    shouldDisplay = !shouldDisplay;
                    value = dropdownValue;
                  });
                },
              )),
          SizedBox(
            height: 20,
          ),
          if (value == "Indigency") conditionalTextField(),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              addRequests();
            },
            color: Colors.green,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Text(
              "Submit Request",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final items = [
    "Clearance",
    "Indigency",
    "Building Permit",
    "Residency",
    "Wiring",
    "Fencing",
    "Water",
    "Excavation",
    "Blotter"
  ];
  String? value;
//Widget for dropdown
  // Widget dropdown() {
  //   return ;
  // }

//Curved container
// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color(0xff555555);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

  Widget conditionalTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
      child: TextField(
        controller: puposeController,
        decoration: InputDecoration(
            labelText: "Purpose",
            fillColor: Colors.white,
            filled: true,
            hintText: "Purpose of Indigency",
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }
}
