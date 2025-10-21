// models/user_model.dart
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});

  factory UserModel.fromFirebase(User user) {
    return UserModel(uid: user.uid, email: user.email ?? '');
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
}