import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/model/user_model.dart';

class FirebaseService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authState => auth.authStateChanges();

  static CollectionReference<UserModel> firestore =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          );

  Future<void> addUser(
      String name, String email, String image, String id) async {
    return await firestore
        .doc(id)
        .set(UserModel(name: name, email: email, image: image));
  }

  Future<void> updateUser(
      String name, String email, String image, String id) async {
    return await firestore.doc(id).update(
        UserModel(name: name, email: email, image: image).toFirestore());
  }

  Future<void> logout() {
    return auth.signOut().then((value) {
      GoogleSignIn().signOut();
    });
  }
}
