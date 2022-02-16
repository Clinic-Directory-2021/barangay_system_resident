import 'package:barangay_system_resident/forgot_password_page.dart';
import 'package:barangay_system_resident/homepage.dart';
import 'package:barangay_system_resident/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();
  String _email = "", _password = "";
  bool _obscureText = true;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget inputFile(
      {label,
      obscureText = false,
      icon = Icons.email,
      storeTo,
      suffix,
      controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
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
        backgroundColor: Colors.green,
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           colors: [Color(0xff20bf55), Color(0xff01baef)],
        //           begin: Alignment.topLeft)),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
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
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    inputFile(
                        label: "Email",
                        icon: Icons.email,
                        storeTo: 'email',
                        controller: email_controller),
                    inputFile(
                        controller: pass_controller,
                        label: "password",
                        obscureText: _obscureText,
                        icon: Icons.password,
                        suffix: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        storeTo: 'password'),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassPage()));
                        })
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
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
                      if (_email == "" || _password == "") {
                        Fluttertoast.showToast(
                          msg: "All fields are required.",
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 18,
                        );
                      } else {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password);
                          Homepage.OldPassword = _password;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                          email_controller.clear();
                          pass_controller.clear();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(
                              msg: "Username or Password is Incorrect.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 18,
                            );
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(
                              msg: "Username or Password is Incorrect.",
                              toastLength: Toast.LENGTH_SHORT,
                              fontSize: 18,
                            );
                          }
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
      ),
    );
  }
}
