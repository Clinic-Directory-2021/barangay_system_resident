import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
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
                  inputFile(label: "Email", icon: Icons.email),
                  inputFile(
                      label: "password",
                      obscureText: true,
                      icon: Icons.password)
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
                  onPressed: () {},
                  color: Color(0xff0095ff),
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

//Widget for inputfile
Widget inputFile({label, obscureText = false, icon = Icons.email}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
