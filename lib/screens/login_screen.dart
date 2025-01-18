import 'package:akti3_firebase_app/screens/dashboard_screen.dart';
import 'package:akti3_firebase_app/screens/email_verification_screen.dart';
import 'package:akti3_firebase_app/screens/forgot_password_screen.dart';
import 'package:akti3_firebase_app/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
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
                    onPressed: () async {
                      String email = emailController.text;
                      String pass = passController.text;

                      if (email.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Please provide email and password')));
                        return;
                      }

                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        UserCredential userCredentials = await auth.signInWithEmailAndPassword(
                          email: email,
                          password: pass,
                        );

                        if( userCredentials.user != null ){

                          // is the user email verified

                          print('*******************************');
                          print(userCredentials.user!.emailVerified);
                          if( userCredentials.user!.emailVerified){

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("User Shta"))
                            );

                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                              return DashboardScreen();
                            }));
                          }
                          else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return EmailVerificationScreen();
                            }));
                          }
                          // if not verified, send him a verification email

                          // after verification, allow him to Dashboard screen



                        }

                      } on FirebaseAuthException catch (e) {

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? ''))
                        );
                      }

                    },
                    child: const Text('LOGIN')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
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
