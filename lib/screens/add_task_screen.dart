import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  var taskNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                hintText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(onPressed: ()  async {
              String uid = FirebaseAuth.instance.currentUser!.uid;
              int dt = DateTime.now().millisecondsSinceEpoch;

              FirebaseFirestore db = FirebaseFirestore.instance;

              var taskRef = db.collection('tasks').doc(uid).collection('tasks').doc();

              await taskRef.set({
                'taskId': taskRef.id,
                'taskName': taskNameController.text,
                'dt': dt,

              });


            }, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
