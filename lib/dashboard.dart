import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:barangay_system_resident/profile.dart';

import 'package:fluttertoast/fluttertoast.dart';

bool shouldDisplay = false;
final puposeController = TextEditingController();
final complainantController = TextEditingController();
final applicant_name = TextEditingController();
final place_of_business = TextEditingController();
final refNoController = TextEditingController();

String first_name = "";
String middle_name = "";
String last_name = "";
String gender = "";
String profilePic = "";
String email = "";

String age = "";
String birthdate = "";
String birthplace = "";
String civil_status = "";

// int request_remaining = 5;
// var pastDueDate;

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference currentUserCollectionRef =
      FirebaseFirestore.instance.collection('resident_list');
  Future<void> updateUser() {
    return currentUserCollectionRef
        .doc(currentUser?.uid)
        .update({'status': 'Online'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // Future<void> showQRCode() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Payment Tab'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Image.asset(
  //                 'assets/cert_indigent.jpg',
  //                 height: 200,
  //                 width: 200,
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               TextFormField(
  //                 onChanged: (value) {},
  //                 decoration: InputDecoration(
  //                     labelText: "Reference Number",
  //                     hintText: "Enter Reference Number",
  //                     contentPadding:
  //                         EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(color: Colors.grey),
  //                     ),
  //                     border: OutlineInputBorder(
  //                         borderSide: BorderSide(color: Colors.grey))),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 "Please send your payment via gcash using this QR code, once sent input the Ref. No. that is texted to you by Gcash and submit it here. Email will be sent to you once your request has been successfully accepted.",
  //                 style: TextStyle(fontSize: 12, color: Colors.grey[700]),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Confirm'),
  //             onPressed: () {},
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    updateUser();
    FirebaseFirestore.instance
        .collection('resident_list')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          first_name = doc["first_name"];
          middle_name = doc["middle_name"];
          last_name = doc["last_name"];
          gender = doc["gender"];
          profilePic = doc["resident_img_url"];

          email = doc['email'];
          age = doc['age'];
          birthdate = doc['birthdate'];
          birthplace = doc['birthplace'];
          civil_status = doc['civil_status'];
          // pastDueDate =
          //     DateTime.parse(doc['requestWillBeAvailable'].toDate().toString());
        });
      });
    });

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('resident_list')
        .doc(currentUser?.uid);

    // var today = DateTime.now();
    // var oneDayFromNow = today.add(const Duration(days: 1));

    // try {
    //   final bool isPastDate = pastDueDate.isBefore(today);
    //   if (isPastDate) {
    //     documentReference.update({
    //       'request_remaining': 5,
    //       'requestWillBeAvailable': oneDayFromNow,
    //     });
    //   }
    // } catch (e) {
    //   print("isBefore is not yet instantiate");
    // }

    // FirebaseFirestore.instance.runTransaction((transaction) async {
    //   // Get the document
    //   DocumentSnapshot snapshot = await transaction.get(documentReference);

    //   if (!snapshot.exists) {
    //     throw Exception("User does not exist!");
    //   }

    //   // Update the follower count based on the current count
    //   // Note: this could be done without a transaction
    //   // by updating the population using FieldValue.increment()
    //   var snaps = snapshot.data() as Map;

    //   setState(() {
    //     request_remaining = snaps['request_remaining'];
    //   });

    //   // Return the new count
    //   // return newFollowerCount;
    // });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collection_ref =
        FirebaseFirestore.instance.collection('certificate_requests');

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('resident_list')
        .doc(currentUser?.uid);

    Future<void> addRequests() async {
      String epochTime = DateTime.now().millisecondsSinceEpoch.toString();
      // FirebaseFirestore.instance.runTransaction((transaction) async {
      //   // Get the document
      //   DocumentSnapshot snapshot = await transaction.get(documentReference);

      //   if (!snapshot.exists) {
      //     throw Exception("User does not exist!");
      //   }

      //   // Update the follower count based on the current count
      //   // Note: this could be done without a transaction
      //   // by updating the population using FieldValue.increment()
      //   var snaps = snapshot.data() as Map;

      //   if (snaps['request_remaining'] > 1) {
      //     setState(() {
      //       request_remaining = snaps['request_remaining'] - 1;
      //     });
      //   }
      //   if (snaps['request_remaining'] == 1) {
      //     request_remaining = 0;
      //     var today = DateTime.now();
      //     var oneDayFromNow = today.add(const Duration(days: 1));
      //     documentReference.update({
      //       'requestWillBeAvailable': oneDayFromNow,
      //       'request_remaining': 0,
      //     });
      //   }

      //   Perform an update on the document
      //   if (request_remaining > 0) {
      //     transaction.update(
      //         documentReference, {'request_remaining': request_remaining});
      //   }

      //   // Return the new count
      //   // return newFollowerCount;
      // });

      // Call the user's CollectionReference to add a new user
      return await collection_ref.doc(epochTime).set({
        'certificate_type': value,
        'request_id': epochTime,
        'first_name': first_name,
        'middle_name': middle_name,
        'last_name': last_name,
        'gender': gender,
        'resident_img_url': profilePic,
        'email': email,
        'resident_id': currentUser?.uid,
        'status': 'Pending',
        'age': age,
        'birthdate': birthdate,
        'birthplace': birthplace,
        'civil_status': civil_status,
        'purpose': puposeController.text,
        'ref_no': refNoController.text,
        'place_of_business': place_of_business.text,
        'applicant_name': applicant_name.text,
      }).then((value) {
        Fluttertoast.showToast(
          msg: "Request Added!",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 18,
        );
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: "Failed to add Request: $error",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 18,
        );
      });

      // if (request_remaining > 0) {
      // } else {
      //   Fluttertoast.showToast(
      //     msg: "Reach Limit of Requests for Today Please Come back tommorow!",
      //     toastLength: Toast.LENGTH_SHORT,
      //     fontSize: 18,
      //   );
      //   // var today = DateTime.now();
      //   // var oneDayFromNow = today.add(const Duration(days: 1));
      //   // documentReference.update({
      //   //   'requestWillBeAvailable': oneDayFromNow,
      //   // });
      //   // return Fluttertoast.showToast(
      //   //   msg: "Reach Limit of Requests for Today Please Come back tommorow!",
      //   //   toastLength: Toast.LENGTH_SHORT,
      //   //   fontSize: 18,
      //   // );
      // }
    }

    Future<void> showQRCode() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Tab'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset(
                    'assets/cert_indigent.jpg',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: refNoController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: "Reference Number",
                        hintText: "Enter Reference Number",
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
                  Text(
                    "Please send your payment via gcash using this QR code, once sent input the Ref. No. that is texted to you by Gcash and submit it here. Email will be sent to you once your request has been successfully accepted.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  addRequests();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> showQRCodeConvinience() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Tab'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset(
                    'assets/new_qr_code.jpg',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: refNoController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: "Reference Number",
                        hintText: "Enter Reference Number",
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
                  Text(
                    "Please send your payment via gcash using this QR code, once sent input the Ref. No. that is texted to you by Gcash and submit it here. Email will be sent to you once your request has been successfully accepted.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  addRequests();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> showQRCodeSari() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Tab'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset(
                    'assets/sari_sari_qr.jpg',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: refNoController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: "Reference Number",
                        hintText: "Enter Reference Number",
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
                  Text(
                    "Please send your payment via gcash using this QR code, once sent input the Ref. No. that is texted to you by Gcash and submit it here. Email will be sent to you once your request has been successfully accepted.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  addRequests();
                },
              ),
            ],
          );
        },
      );
    }
    // Future<void> processRequest() {}

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Select certificate you want to issue:',
                    style: TextStyle(fontSize: 18, fontFamily: 'Calibri'),
                  )),
              SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: 5, top: 5, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white),
                      child: Column(children: [
                        DropdownButtonFormField<String>(
                          value: value,
                          decoration:
                              InputDecoration(prefixIcon: Icon(Icons.article)),
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
                        )
                      ]))),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              if (value == "Indigency")
                conditionalTextField("Purpose of Indigency"),
              if (value == "Blotter") conditionalTextField3("Complainant"),
              if (value == "Business(Sari-Sari)" ||
                  value == "Business(Convinience)")
                conditionalTextField2("Applicant Name", "Place of Business"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              MaterialButton(
                onPressed: () {
                  // addRequests();

                  if (value == "Business(Sari-Sari)") {
                    showQRCodeSari();
                  } else if (value == "Business(Convinience)") {
                    showQRCodeConvinience();
                  } else {
                    showQRCode();
                  }
                },
                color: Colors.green,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Submit Request",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              // Text("You have " + request_remaining.toString() + " remaining"),
            ],
          ),
        ));
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
    "Blotter",
    "Business(Sari-Sari)",
    "Business(Convinience)"
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

  Widget conditionalTextField(hint) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
      child: TextField(
        controller: puposeController,
        decoration: InputDecoration(
            labelText: hint,
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }

  Widget conditionalTextField2(hint1, hint2) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
      child: Column(children: [
        TextField(
          controller: applicant_name,
          decoration: InputDecoration(
              labelText: hint1,
              fillColor: Colors.white,
              filled: true,
              hintText: hint1,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: place_of_business,
          decoration: InputDecoration(
              labelText: hint2,
              fillColor: Colors.white,
              filled: true,
              hintText: hint2,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        )
      ]),
    );
  }
}

Widget conditionalTextField3(hint) {
  return Container(
    margin: EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
    child: TextField(
      controller: complainantController,
      decoration: InputDecoration(
          labelText: hint,
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    ),
  );
}
