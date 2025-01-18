import 'package:akti3_firebase_app/screens/add_task_screen.dart';
import 'package:akti3_firebase_app/screens/login_screen.dart';
import 'package:akti3_firebase_app/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
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
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ProfileScreen();
            }));
          }, icon: Icon(Icons.person)),

          IconButton(onPressed: (){

            FirebaseAuth.instance.signOut();

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return LoginScreen();
            }));
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
