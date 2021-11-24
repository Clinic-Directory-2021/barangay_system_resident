import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  CollectionReference users = FirebaseFirestore.instance
      .collection('list_of_issued_certificate_clearance');

  var currentUser = FirebaseAuth.instance.currentUser;
  List certificates = [];

  int progress = 0;
  ReceivePort recievePort = ReceivePort();

  //INIT STATE
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        recievePort.sendPort, "downloadingcertificate");

    recievePort.listen((message) {
      setState(() {
        progress = message;
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_residency')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_blotter')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_building')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_clearance')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_excavation')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_fencing')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_indigent')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_water')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });

    FirebaseFirestore.instance
        .collection('list_of_issued_certificate_wiring')
        .where('resident_id', isEqualTo: currentUser?.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          certificates.add([
            doc["clearance_type"],
            doc["residency_pdf_url"],
          ]);
        });
      });
    });
  }

  //END INIT STATE

  static downloadCallback(id, status, progress) {
    SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloadingcertificate');
    sendPort!.send(progress);
  }

  Future<void> _downloadFile(String url, String fileName) async {
    final status = await Permission.storage.request();
    String epochTime = DateTime.now().millisecondsSinceEpoch.toString();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(
        url: url,
        // savedDir: baseStorage!.path,
        savedDir: '/storage/emulated/0/Download',
        fileName: epochTime + fileName + ".pdf",
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } else {
      print('No Permission!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('Notifications'),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //List of notification item
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
                    Text("Good Day Mr./Ms./Mrs. The " +
                        i[0].toString() +
                        " certificate that you requested is approved. You can download now the pdf here."),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () async {
                        _downloadFile(i[1].toString(), i[0].toString());
                      },
                      color: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Download here",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     border: Border.all(
            //         color: Colors.grey, // set border color
            //         width: 1.0), // set border width
            //   ),
            //   child: Column(
            //     children: [
            //       Text(
            //           "Good Day Mr./Ms./Mrs. The name_of_certificate certificate that you requested is approved. You can download now the pdf here."),
            //       SizedBox(height: 10),
            //       MaterialButton(
            //         onPressed: () {},
            //         color: Colors.green,
            //         elevation: 0,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5)),
            //         child: Text(
            //           "Download here",
            //           style: TextStyle(
            //             fontWeight: FontWeight.w600,
            //             fontSize: 12,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //End of list
          ],
        ),
      ),
    );
  }
}
