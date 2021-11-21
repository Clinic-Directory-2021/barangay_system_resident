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
                textfield(hintText: "First name", icon: Icons.person),
                SizedBox(
                  height: 20,
                ),
                textfield(
                    hintText: "Midle name", icon: Icons.account_box_outlined),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Last name", icon: Icons.account_box),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Email"),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Gender", icon: Icons.male),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Civil Status", icon: Icons.add_location),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Age", icon: Icons.assignment_ind_outlined),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Birth Date", icon: Icons.cake),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Phone Number", icon: Icons.ad_units),
                SizedBox(
                  height: 20,
                ),
                textfield(
                    hintText: "Birth Place",
                    icon: Icons.add_location_alt_outlined),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Street", icon: Icons.add_road),
                SizedBox(
                  height: 20,
                ),
                textfield(
                    hintText: "Purok/Area",
                    icon: Icons.add_location_alt_outlined),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Citizenship", icon: Icons.book),
                SizedBox(
                  height: 20,
                ),
                textfield(
                    hintText: "Differently Disabled Person",
                    icon: Icons.accessible_rounded),
                SizedBox(
                  height: 20,
                ),
                textfield(
                    hintText: "Relation to Head Family",
                    icon: Icons.account_balance),
                SizedBox(
                  height: 20,
                ),
                textfield(hintText: "Religion", icon: Icons.add),
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
