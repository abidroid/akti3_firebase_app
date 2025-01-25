import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key, required this.documentSnapshot});

  final DocumentSnapshot documentSnapshot;

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {

  var taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskController.text = widget.documentSnapshot['taskName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: 'Task Name',
                border: OutlineInputBorder()
              ),
            ),
            
            ElevatedButton(onPressed: (){

              String updatedTask = taskController.text;

              String uid = FirebaseAuth.instance.currentUser!.uid;

              // FirebaseFirestore.instance.collection('tasks')
              // .doc(uid).collection('tasks')
              // .doc(widget.documentSnapshot['taskId'])
              // .update({
              //   'taskName': updatedTask,
              // });


              widget.documentSnapshot.reference.update({
                'taskName': updatedTask,
                'dt': DateTime.now().millisecondsSinceEpoch
              });




            }, child: const Text("UPDATE"))
          ],
        ),
      ),
    );
  }
}
