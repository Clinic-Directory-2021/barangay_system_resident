import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                'Select certificate you want to issue:',
                style: TextStyle(fontSize: 18, fontFamily: 'Calibri'),
              )),
          dropdown(),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {},
            color: Colors.green,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Text(
              "Submit",
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
}

final items = [
  "Clearance",
  "Indegency",
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
Widget dropdown() {
  return Container(
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
        onChanged: (s) {
          value = s;
        },
      ));
}

//Curved container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
