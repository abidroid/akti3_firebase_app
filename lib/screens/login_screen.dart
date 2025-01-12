import 'package:akti3_firebase_app/screens/dashboard_screen.dart';
import 'package:akti3_firebase_app/screens/forgot_password_screen.dart';
import 'package:akti3_firebase_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: const Text('Login'),

        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: emailController,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ForgotPasswordScreen();
                        }));
                      },
                      child: const Text(
                        "Forgot Password?",
                        textAlign: TextAlign.end,
                      )),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white),
                    onPressed: () {

                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return DashboardScreen();
                      }));
                    },
                    child: const Text('LOGIN')),
                TextButton(
                    onPressed: () {

                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SignUpScreen();
                      }));

                    },
                    child: const Text("Not Registered Yet? SIGN UP"))
              ],
            ),
          ),
        ));
  }
}
