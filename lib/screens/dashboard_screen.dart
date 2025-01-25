import 'package:akti3_firebase_app/screens/add_task_screen.dart';
import 'package:akti3_firebase_app/screens/login_screen.dart';
import 'package:akti3_firebase_app/screens/profile_screen.dart';
import 'package:akti3_firebase_app/screens/update_task_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CollectionReference? collectionReference;

  @override
  void initState() {
    super.initState();

    String uid = FirebaseAuth.instance.currentUser!.uid;
    collectionReference = FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('tasks');
  }

  TextStyle myTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddTaskScreen();
          }));
        },
        icon: Icon(Icons.add),
        label: Text('Add Task'),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              },
              icon: Icon(Icons.person)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: StreamBuilder(
          stream: collectionReference!.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot querySnapshot = snapshot.data as QuerySnapshot;
              List<QueryDocumentSnapshot> docs = querySnapshot.docs;

              if (docs.isEmpty) {
                return Center(
                  child: Text('No Tasks'),
                );
              } else {
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 18),
                              // color: Colors.blue,
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    docs[index]['taskName'],
                                    style: myTextStyle,
                                  ),
                                  Text(
                                    getHumanReadableDate(docs[index]['dt']),
                                    style: myTextStyle.copyWith(
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    collectionReference!
                                        .doc(docs[index]['taskId'])
                                        .delete();
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return UpdateTaskScreen(
                                          documentSnapshot: docs[index]);
                                    }));
                                  },
                                  icon: Icon(Icons.edit)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: SpinKitDualRing(color: Colors.green),
              );
            }
          }),
    );
  }

  String getHumanReadableDate(int dt) {
    DateFormat dateFormat = DateFormat('dd/MM/yy hh:mm a');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);

    String humanDate = dateFormat.format(dateTime);

    return humanDate;
  }
}
