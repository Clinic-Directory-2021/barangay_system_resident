// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:barangay_system_resident/login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  bool _password_obscureText = true;
  bool _confirm_obscureText = true;
  String img_file_directory = "";
  String fileName = "";

  var currentUser = FirebaseAuth.instance.currentUser;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        fileName = image.path.split('/').last;
        this.image = imageTemporary;
      });
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        fileName = image.path.split('/').last;
        this.image = imageTemporary;
      });
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildButton(
          {required String title,
          required IconData icon,
          required VoidCallback onClicked}) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: TextStyle(fontSize: 20)),
        child: Row(
          children: [
            Icon(
              icon,
              size: 15,
            ),
            const SizedBox(width: 10),
            Text(title)
          ],
        ),
        onPressed: onClicked,
      );
  DateTime? _dateTime;

  String _first_name = "",
      _middle_name = "",
      _last_name = "",
      _email = "",
      _password = "",
      _confirm_password = "",
      _civil_status = "",
      _age = "",
      _phone_number = "",
      _birthplace = "",
      _purok = "",
      _citizenship = "",
      _diff_disabled = "",
      _relation = "",
      _religion = "",
      _user_id = "",
      _street = "";

//Widget for inputfile
  Widget inputFile(
      {label, obscureText = false, icon = Icons.email, storeTo, suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          onChanged: (value) {
            setState(() {
              if (storeTo == 'email') {
                _email = value.trim();
              } else if (storeTo == 'password') {
                _password = value.trim();
              } else if (storeTo == 'confirm_password') {
                _confirm_password = value.trim();
              } else if (storeTo == 'first_name') {
                _first_name = value.trim();
              } else if (storeTo == 'middle_name') {
                _middle_name = value.trim();
              } else if (storeTo == 'last_name') {
                _last_name = value.trim();
              } else if (storeTo == 'civil_status') {
                _civil_status = value.trim();
              } else if (storeTo == 'age') {
                _age = value.trim();
              } else if (storeTo == 'phone_number') {
                _phone_number = value.trim();
              } else if (storeTo == 'birthplace') {
                _birthplace = value.trim();
              } else if (storeTo == 'purok') {
                _purok = value.trim();
              } else if (storeTo == 'citizenship') {
                _citizenship = value.trim();
              } else if (storeTo == 'diff_disabled') {
                _diff_disabled = value.trim();
              } else if (storeTo == 'relation') {
                _relation = value.trim();
              } else if (storeTo == 'religion') {
                _religion = value.trim();
              } else if (storeTo == 'street') {
                _religion = value.trim();
              }
            });
          },
          decoration: InputDecoration(
              labelText: label,
              hintText: label,
              prefixIcon: Icon(icon),
              suffixIcon: suffix,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collection_ref =
        FirebaseFirestore.instance.collection('resident_list');

    Future<void> addResident() async {
      // Call the user's CollectionReference to add a new user
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        _user_id = userCredential.user!.uid;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 18,
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 18,
          );
        }
      } catch (e) {
        print(e);
      }

      img_file_directory = _user_id + '/resident_images/' + fileName;
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref(img_file_directory)
            .putFile(image!);
      } on firebase_core.FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 18,
        );
      }

      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(img_file_directory)
          .getDownloadURL();
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      return collection_ref
          .doc(_user_id)
          .set({
            'resident_id': _user_id,
            'first_name': _first_name,
            'middle_name': _middle_name,
            'last_name': _last_name,
            'gender': genderValue,
            'email': _email,
            'age': _age,
            'birthdate': _dateTime.toString(),
            'birthplace': _birthplace,
            'civil_status': _civil_status,
            'purok': _purok,
            'citizenship': _citizenship,
            'relation': _relation,
            'diff_disabled': _diff_disabled,
            'phone_number': _phone_number,
            'religion': _religion,
            'status': 'Offline',
            'street': _street,
            'resident_img_directory': img_file_directory,
            'resident_img_url': downloadURL,
          })
          .then((value) => print("Resident Added"))
          .catchError((error) => print("Failed to add Resident: $error"));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff20bf55), Color(0xff01baef)],
                  begin: Alignment.topLeft)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's Free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  image != null
                      ? ClipOval(
                          child: Image.file(
                          image!,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ))
                      : FlutterLogo(size: 160),
                  Row(
                    children: [
                      buildButton(
                          title: "Pick Gallery",
                          icon: Icons.image_outlined,
                          onClicked: () => pickImage()),
                      buildButton(
                          title: "Use Camera",
                          icon: Icons.camera,
                          onClicked: () => takeImage()),
                    ],
                  ),

                  inputFile(
                      label: "First Name",
                      icon: Icons.perm_identity,
                      storeTo: 'first_name'),
                  inputFile(
                      label: "Middle name",
                      icon: Icons.perm_identity_rounded,
                      storeTo: 'middle_name'),
                  inputFile(
                      label: "Last Name",
                      icon: Icons.perm_identity_outlined,
                      storeTo: 'last_name'),
                  dropdown(),
                  inputFile(
                      label: "Email", icon: Icons.email, storeTo: 'email'),
                  inputFile(
                      label: "Password",
                      icon: Icons.password,
                      suffix: IconButton(
                        icon: Icon(_password_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _password_obscureText = !_password_obscureText;
                          });
                        },
                      ),
                      obscureText: _password_obscureText,
                      storeTo: 'password'),
                  inputFile(
                      label: "Confirm Password",
                      icon: Icons.password,
                      suffix: IconButton(
                        icon: Icon(_confirm_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _confirm_obscureText = !_confirm_obscureText;
                          });
                        },
                      ),
                      obscureText: _confirm_obscureText,
                      storeTo: 'confirm_password'),
                  inputFile(
                      label: "Civil Status",
                      icon: Icons.add_location,
                      storeTo: 'civil_status'),
                  inputFile(
                      label: "Age",
                      icon: Icons.assignment_ind_outlined,
                      storeTo: 'age'),
                  //Date picker
                  Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Row(
                      children: <Widget>[
                        // ignore: unnecessary_null_comparison
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2222))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                            child: Text('Pick a Date')),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _dateTime == null
                              ? 'Select your Birth Date'
                              : convertDateTimeDisplay(_dateTime.toString()),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  //End of date picker
                  inputFile(
                      label: "Phone Number",
                      icon: Icons.ad_units,
                      storeTo: 'phone_number'),
                  inputFile(
                      label: "Birth Place",
                      icon: Icons.add_location_alt_outlined,
                      storeTo: 'birthplace'),
                  inputFile(label: "Street", icon: Icons.add_road),
                  inputFile(
                      label: "Purok/Area",
                      icon: Icons.add_location_alt_outlined,
                      storeTo: 'purok'),
                  inputFile(
                    label: "Street",
                    icon: Icons.add_road,
                    storeTo: 'street',
                  ),
                  inputFile(
                      label: "Citizenship",
                      icon: Icons.book,
                      storeTo: 'citizenship'),
                  inputFile(
                      label: "Differently Disabled Person",
                      icon: Icons.accessible_rounded,
                      storeTo: 'diff_disabled'),
                  inputFile(
                      label: "Relation to Head Family",
                      icon: Icons.account_balance,
                      storeTo: 'relation'),
                  inputFile(
                      label: "Religion", icon: Icons.add, storeTo: 'religion'),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 3,
                  left: 3,
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    if (_password == _confirm_password &&
                        _first_name != "" &&
                        _middle_name != "" &&
                        _last_name != "" &&
                        _email != "" &&
                        _password != "" &&
                        _confirm_password != "" &&
                        _civil_status != "" &&
                        _age != "" &&
                        _phone_number != "" &&
                        _birthplace != "" &&
                        _purok != "" &&
                        _citizenship != "" &&
                        _diff_disabled != "" &&
                        _relation != "" &&
                        _religion != "" &&
                        _dateTime != null &&
                        genderValue != "" &&
                        image != null) {
                      addResident();
                    } else if (_password != _confirm_password) {
                      print("Password Do not Match");
                      Fluttertoast.showToast(
                        msg: "Password Do not Match",
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 18,
                      );
                    } else {
                      print("please fill up all the fields");
                      Fluttertoast.showToast(
                        msg: "please fill up all the fields",
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 18,
                      );
                    }
                  },
                  color: Colors.green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text("Already have an account?"),
              //     Text(
              //       " Login",
              //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

final items = ["Select your gender", "Male", "Female"];
String? genderValue;
//Widget for dropdown/Gender
Widget dropdown() {
  return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: DropdownButtonFormField<String>(
        value: genderValue,
        decoration: InputDecoration(prefixIcon: Icon(Icons.male)),
        iconSize: 36,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        hint: Text("Select your Gender"),
        style: TextStyle(color: Colors.black),
        isExpanded: true,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (s) {
          genderValue = s;
        },
      ));
}

//Date picker for Birth Date
String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
  final DateFormat serverFormater = DateFormat('MM-dd-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}
