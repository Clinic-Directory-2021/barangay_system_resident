import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List certificates = [];
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('approved_requests')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["date"],
          ]);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      for (var i in certificates)
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey, // set border color
                width: 1.0), // set border width
          ),
          child: Column(
            children: [
              Text(i[0] + '\n' + i[1]),
              SizedBox(height: 10),
            ],
          ),
        )
    ]);
  }
}

// class Entry {
//   final String title;
//   final String date;
//   final List<Entry> children;
//   Entry(this.title, this.date, [this.children = const <Entry>[]]);
// }

//Entire multi-level list displayed by this app
//* The query and data should traverse here


//Create widget for row
// class EntryItem extends StatefulWidget {
//   const EntryItem(this.entry);
//   final Entry entry;

//   @override
//   State<EntryItem> createState() => _EntryItemState();
// }

// class _EntryItemState extends State<EntryItem> {
//   Widget _buildTiles(Entry root) {
//     if (root.children.isEmpty) {
//       return ListTile(
//         leading: const Icon(
//           Icons.check,
//           color: Colors.green,
//         ),
//         title: Text(root.title),
//         subtitle: Text(root.date),
//       );
//     }
//     return ExpansionTile(
//       key: PageStorageKey<Entry>(root),
//       title: Text(root.title),
//       children: root.children.map<Widget>(_buildTiles).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return FutureBuilder<DocumentSnapshot>(
//     //   future: users.doc(currentUser?.uid).get(),
//     //   builder:
//     //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//     //     if (snapshot.hasError) {
//     //       return Text("Something went wrong");
//     //     }

//     //     if (snapshot.hasData && !snapshot.data!.exists) {
//     //       return Text("Document does not exist");
//     //     }

//     //     if (snapshot.connectionState == ConnectionState.done) {
//     //       Map<String, dynamic> data =
//     //           snapshot.data!.data() as Map<String, dynamic>;
//     //       // return Text("Full Name: ${data['first_name']} ${data['last_name']}");
//     //       return _buildTiles(
//     //           widget.entry, data['date'], data['clearance_type']);
//     //     }
//     //     return Text("loading");
//     //   },
//     // );

//     return _buildTiles(widget.entry);
//   }
// }
// }
