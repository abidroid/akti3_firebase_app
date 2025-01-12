import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()),
                ),
                TextField(
                  controller:  emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder()),
                ),
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                ),

                TextField(
                  controller: confirmController,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () async {

                      String name =  nameController.text;
                      String email = emailController.text;
                      String pass = passController.text;
                      String confirmPass = confirmController.text;

                      // Front End Validation

                      // if( name.isEmpty){
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please provide name')));
                      //
                      // }
                      //
                      // if( pass.length < 6){
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password must be at least 6 characters')));
                      //   return;
                      // }
                      //
                      // if( pass != confirmPass){
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password does not match')));
                      //   return;
                      // }
                      // code

                      // firebase auth

                      FirebaseAuth auth = FirebaseAuth.instance;

                      UserCredential userCredentials = await auth.createUserWithEmailAndPassword(email: email, password: pass);


                    },
                    child: const Text('SIGN UP')),
              ],
            ),
          ),
        ));
  }
}
