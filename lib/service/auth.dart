import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  grtCurrentUser() async {
    return await _auth.currentUser;
  }

  Future singOut() async {
    await _auth.signOut();
  }

  Future deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? id = user?.uid;
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(id);

    await userDoc.delete();

    await user?.delete();
  }
}
