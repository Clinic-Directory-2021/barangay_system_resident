import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatelessWidget {
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                  inputFile(label: "First Name", icon: Icons.perm_identity),
                  inputFile(
                      label: "Last Name", icon: Icons.perm_identity_outlined),
                  dropdown(),
                  inputFile(label: "Email", icon: Icons.email),
                  inputFile(
                      label: "Password",
                      icon: Icons.password,
                      obscureText: true),
                  inputFile(
                      label: "Confirm Password",
                      icon: Icons.password,
                      obscureText: true),
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
                  onPressed: () {},
                  color: Color(0xff0095ff),
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
        )),
      ),
    );
  }
}

//Widget for inputfile
Widget inputFile({label, obscureText = false, icon = Icons.email}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: label,
            hintText: label,
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

final items = ["Select your gender", "Male", "Female"];
String? value;
//Widget for dropdown
Widget dropdown() {
  return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
      child: DropdownButtonFormField<String>(
        value: value,
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
          value = s;
        },
      ));
}
