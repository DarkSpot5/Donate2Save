import 'package:firebase_auth/firebase_auth.dart';

class Model {
  UserCredential? userCredential;
  String? uid;
  String? name;
  String? contactNumber;
  String? email;
  String? role;
  bool isVerified = false;
  DateTime? verificationTimestamp;

  static final Model _instance = Model._internal();
  factory Model() => _instance;

  Model._internal();

  void reset() {
    userCredential = null;
    uid = null;
    name = null;
    contactNumber = null;
    email = null;
    role = null;
    isVerified = false;
    verificationTimestamp = null;
    }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'role': role,
      'isVerified': isVerified,
      'verificationTimestamp': verificationTimestamp?.toIso8601String(),
    };
  }

  void fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    contactNumber = data['contactNumber'];
    email = data['email'];
    role = data['role'];
    isVerified = data['isVerified'] ?? false;
    verificationTimestamp = data['verificationTimestamp'] != null
        ? DateTime.parse(data['verificationTimestamp'])
        : null;
  }
}