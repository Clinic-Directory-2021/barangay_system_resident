import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 10),
      child: Expanded(
          // padding: EdgeInsets.symmetric(
          //   horizontal: 40,
          // ),
          // height: MediaQuery.of(context).size.height - 50,
          // width: double.infinity,
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
                textfield(hintText: "First name"),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Midle name"),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Last name"),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Email"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

//textfield in profile

Widget textfield({required String hintText}) {
  return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
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
