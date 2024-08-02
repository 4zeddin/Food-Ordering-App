import 'dart:io';

import 'package:app/pages/auth/login.dart';
import 'package:app/service/shared_pref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:app/service/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      setState(() {
        uploadItem();
      });
    }
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {
        profile = downloadUrl;
      });
    }
  }

  getthesharedpref() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onthisload();
  }

  void _showConfirmationDialog(
      {required String action, required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(action == 'delete' ? 'Confirm Deletion' : 'Confirm Logout'),
          content: Text(action == 'delete'
              ? 'Are you sure you want to delete your account?'
              : 'Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Perform the action
              },
              child: Text(action == 'delete' ? 'Delete' : 'Logout', style: const TextStyle(color: Colors.redAccent),),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser() async {
    await AuthMethods().deleteUser();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogIn()));
  }

  void _logout() async {
    await AuthMethods().singOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 45.0, left: 20.0, right: 20.0),
                      height: MediaQuery.of(context).size.height / 4.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 105.0))),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6.5),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(60),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: selectedImage == null
                                  ? profile == null
                                      ? Image.asset(
                                          "images/user.png",
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          profile!,
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        )
                                  : Image.file(
                                      selectedImage!,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name ?? 'Loading...',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                buildInfoCard('Name', name, Icons.person),
                const SizedBox(
                  height: 30.0,
                ),
                buildInfoCard('Email', email, Icons.email),
                const SizedBox(
                  height: 30.0,
                ),
                buildInfoCard('Terms and Condition', null, Icons.description),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    _showConfirmationDialog(
                      action: 'delete',
                      onConfirm: _deleteUser,
                    );
                  },
                  child: buildInfoCard('Delete Account', null, Icons.delete),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    _showConfirmationDialog(
                      action: 'logout',
                      onConfirm: _logout,
                    );
                  },
                  child: buildInfoCard('LogOut', null, Icons.logout),
                ),
              ],
            ),
    );
  }

  Widget buildInfoCard(String title, String? value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                  if (value != null)
                    Text(
                      value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
