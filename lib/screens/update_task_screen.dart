import 'package:flutter/material.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Add Task'),
      ),
      body: const Placeholder(),
    );
  }
}
