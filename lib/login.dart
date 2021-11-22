import 'package:barangay_system_resident/homepage.dart';
import 'package:barangay_system_resident/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "";

  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget inputFile({label, obscureText = false, icon = Icons.email, storeTo}) {
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
              } else {
                _password = value.trim();
              }
            });
          },
          decoration: InputDecoration(
              labelText: label,
              hintText: label,
              prefixIcon: Icon(icon),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Main()));
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ))
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  inputFile(
                      label: "Email", icon: Icons.email, storeTo: 'email'),
                  inputFile(
                      label: "password",
                      obscureText: true,
                      icon: Icons.password,
                      storeTo: 'password')
                ],
              ),
            ),
            Padding(
              //
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 3),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     border: Border(
                //       bottom: BorderSide(color: Colors.black),
                //       top: BorderSide(color: Colors.black),
                //       left: BorderSide(color: Colors.black),
                //       right: BorderSide(color: Colors.black),
                //     )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email,
                          password: _password
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Homepage()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                  },
                  color: Colors.green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // child:
            // Container(
            //   padding: EdgeInsets.only(top: 30, left: 3),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       border: Border(
            //         bottom: BorderSide(color: Colors.black),
            //         top: BorderSide(color: Colors.black),
            //         left: BorderSide(color: Colors.black),
            //         right: BorderSide(color: Colors.black),
            //       )),
            //   child: MaterialButton(
            //     minWidth: double.infinity,
            //     height: 60,
            //     onPressed: () {},
            //     color: Color(0xff0095ff),
            //     elevation: 0,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50)),
            //     child: Text(
            //       "Login",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 18,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text("Don't have an account?"),
            //     Text(
            //       " Sign up",
            //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            //     ),
            //   ],
            // ),

            // Container(
            //   padding: EdgeInsets.only(top: 100),
            //   height: 100,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/bulsu.png"),
            //           fit: BoxFit.fitHeight)),
            // )
          ],
        ),
      ),
    );
  }
}