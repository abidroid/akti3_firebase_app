import 'dart:async';

import 'package:akti3_firebase_app/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  Timer? timer;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkUserEmailVerification();
    });
  }

  checkUserEmailVerification(){
    FirebaseAuth.instance.currentUser!.reload();

    if( FirebaseAuth.instance.currentUser!.emailVerified){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return DashboardScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Please verify your email address'),
            Text('An email has been sent to your email address'),
            SpinKitDualRing(color: Colors.green),

            ElevatedButton(onPressed: (){}, child: Text('Resend Email')),

          ],
        ),
      ),
    );
  }
}
