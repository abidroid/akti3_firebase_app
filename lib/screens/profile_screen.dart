import 'dart:io';

import 'package:akti3_firebase_app/utitlity/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DocumentSnapshot? documentSnapshot;
  File? selectedImageFile;
  bool showLocalImage = false;

  getUserDetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {});
  }

  pickImageToBeUploaded(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: imageSource);

    if (pickedImage != null) {
      selectedImageFile = File(pickedImage.path);
      showLocalImage = true;
      setState(() {});

      // code to upload image to firebase storage

      // get the image url

      // update the user document

    }

  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: documentSnapshot == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: showLocalImage
                            ? FileImage(selectedImageFile!) as ImageProvider
                            : documentSnapshot!['photo'] == null
                                ? null
                                : NetworkImage(documentSnapshot!['photo']),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.camera),
                                                title: Text('Camera'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  pickImageToBeUploaded(
                                                      ImageSource.camera);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.photo),
                                                title: Text('Gallery'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  pickImageToBeUploaded(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: Icon(Icons.camera_alt))),
                      ),

                      // Positioned(
                      //     bottom: 0,
                      //     left: 0,
                      //     child: IconButton(onPressed: (){}, icon: Icon(Icons.photo))),
                    ],
                  ),
                ),
                Text(
                  documentSnapshot!['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  documentSnapshot!['email'],
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Member since ${getHumanReadableDate(documentSnapshot!['dateCreated'])}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
