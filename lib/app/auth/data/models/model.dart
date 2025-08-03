import 'package:firebase_auth/firebase_auth.dart';

class Model {
  UserCredential? userCredential;
  String? uid;
  String? name;
  String? contact;
  String? email;
  String? role;
  String? location;
  bool isVerified = false;
  DateTime? verificationTimestamp;

  static final Model _instance = Model._internal();
  factory Model() => _instance;

  Model._internal();

  void reset() {
    userCredential = null;
    uid = null;
    name = null;
    contact = null;
    email = null;
    role = null;
    location = null;
    isVerified = false;
    verificationTimestamp = null;
    }

  Map<String, dynamic> toJson() {
    return {
      'Uid': uid,
      'Name': name,
      'Contact': contact,
      'Email': email,
      'Role': role,
      'Location': location,
      'IsVerified': isVerified,
      'VerificationTimestamp': verificationTimestamp?.toIso8601String(),
    };
  }

  void fromJson(Map<String, dynamic>? data) {
    if (data == null) return;
    uid = data['Uid'] ?? uid;
    name = data['Name'] ?? name;
    contact = data['Contact'] ?? contact;
    email = data['Email'] ?? email;
    role = data['Role'] ?? role;
    location = data['Location'] ?? location;
    isVerified = data['IsVerified'] ?? isVerified;
    verificationTimestamp = data['VerificationTimestamp'] != null
        ? DateTime.parse(data['VerificationTimestamp'])
        : verificationTimestamp;
  }
}