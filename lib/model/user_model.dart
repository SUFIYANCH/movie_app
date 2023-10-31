import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String image;
  UserModel({
    required this.name,
    required this.email,
    required this.image,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        name: data?["name"], email: data?["email"], image: data?["image"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      "image": image,
    };
  }
}
