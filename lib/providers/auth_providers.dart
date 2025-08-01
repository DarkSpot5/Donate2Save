/*
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app/dashboard/home/presentation/screens/home.dart';
import '../app/auth/presentation/screens/user_profile_setup.dart';
import '../app/auth/presentation/screens/hospital_profile_setup.dart';
import '../app/auth/presentation/screens/email_verification.dart';
import '../core/services/navigation_service.dart';
import '../core/services/snackbar_service.dart';

class AuthProvider with ChangeNotifier
 {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    bool _isLoading = false;
    bool get isLoading => _isLoading;

    User? get currentUser => _auth.currentUser;

    Map<String, dynamic>? currentProfile;
    String? currentRole;

    bool get isHospital => currentRole == 'Hospital';
    String get fullName => currentProfile?['Name'] ?? '';
    String get hospitalName => currentProfile?['Name'] ?? '';
    String get uid => _auth.currentUser?.uid ?? '';

    void _setLoading(bool value)
     {
        _isLoading = value;
        notifyListeners();
     }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      SnackbarService.showSnackbar('Email and password must not be empty.');
      return;
    }

        try
         {
            _setLoading(true);
            UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email,password: password);

            User? user = userCredential.user;

      if (user != null) {
        _setLoading(false);
        await _handlePostLogin(user);
      }
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      SnackbarService.showSnackbar(_getErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      SnackbarService.showSnackbar('Please enter your email address.');
      return;
    }
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
      _setLoading(false);
      // Show success message
      NavigationService.showCustomDialog(
        title: 'Password Reset Email Sent',
        content: 'We have sent a password reset email to the provided address. Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      if (e.code == 'user-not-found') {
        SnackbarService.showSnackbar('No account found with this email address.');
      } else if (e.code == 'invalid-email') {
        SnackbarService.showSnackbar('Invalid email address. Please enter a valid email.');
      } else {
        SnackbarService.showSnackbar('Error: ${e.message}');
      }
    } catch (e) {
      _setLoading(false);
      SnackbarService.showSnackbar('An unexpected error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String email, String password, String confirmPassword, String role) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarService.showSnackbar('All fields are required.');
      return;
    }

    if (password != confirmPassword) {
      SnackbarService.showSnackbar('Passwords do not match.');
      return;
    }

        try
         {
            _setLoading(true);
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email,password: password);

      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection(role).doc(user.uid).set({
          'Email': email,
          'Role': role,
          'isVerified': false,
        });

        await user.sendEmailVerification();
        _setLoading(false);
        // Navigate to email verification page
        NavigationService.navigateToReplacement(
          EmailVerificationScreen(user: user, email: email, selectedRole: role),
        );
      }
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      SnackbarService.showSnackbar(_getErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> saveFcmToken() async {
  try {
    final user = _auth.currentUser;
    if (user == null) return;

    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update({'fcmToken': token});
    }
  } catch (e) {
    debugPrint('FCM token save failed: $e');
  }
}


  Future<void> checkVerificationStatus({required User user, required String selectedRole}) async {
    try {
      _setLoading(true);
      // Delay to allow Firebase to update the email verification status
      await Future.delayed(const Duration(seconds: 2));

      // Reload user from Firebase
      await user.reload();
      final updatedUser = _auth.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        // Update Firestore
        await FirebaseFirestore.instance.collection(selectedRole).doc(updatedUser.uid).update({
          'isVerified': true,
          'VerificationTimestamp': FieldValue.serverTimestamp(),
        });
        _setLoading(false); // Ensure loading stops before navigating
        // Navigate to the appropriate profile setup page
        if (selectedRole == 'Hospital') {
          NavigationService.navigateToReplacement(const HospitalProfileSetupPage());
        } else if (selectedRole == 'User') {
          NavigationService.navigateToReplacement(const UserProfileSetupPage());
        }
      } else {
        // Show "not verified" dialog
        _setLoading(false);
        _showNotVerifiedDialog();
      }
    } catch (e) {
      _setLoading(false);
      SnackbarService.showSnackbar('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<void> resendVerificationEmail(User user) async {
    try {
      _setLoading(true);
      await user.sendEmailVerification();
      _setLoading(false);
      SnackbarService.showSnackbar('Verification email has been resent. Please check your inbox.');
    } catch (e) {
      _setLoading(false);
      SnackbarService.showSnackbar('Failed to resend verification email: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _showNotVerifiedDialog() {
    NavigationService.showCustomDialog(
      title: 'Email Not Verified',
      content: 'Your email is not verified. Please verify your email and try again.',
    );
  }

  //A function to save user profile data to Firestore.
  Future<void> saveUserProfile({
    required String name,
    required String contact,
    required String bloodType,
    required String location,
    required Function(String message) onError,
    required VoidCallback onSuccess,
  }) async {
    if (name.isEmpty || contact.isEmpty || bloodType.isEmpty) {
      onError('All fields are required.');
      return;
    }

    try {
      _setLoading(true);
      User? user = _auth.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('User').doc(user.uid).update({
          'Name': name,
          'Contact': contact,
          'BloodType': bloodType,
          'Location': location,
          'DonationHistory': [],
        });

        onSuccess();
      }
    } catch (e) {
      _setLoading(false);
      onError('Failed to save profile: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  //A function to save hospital profile data to Firestore.
  Future<void> saveHospitalProfile({
    required String hospitalName,
    required String contactInfo,
    required String location,
    required Map<String, int> bloodStock,
    required Function(String message) onError,
    required VoidCallback onSuccess,
  }) async {
    if (hospitalName.isEmpty || contactInfo.isEmpty) {
      onError('All fields are required.');
      return;
    }

    try {
      _setLoading(true);
      User? user = _auth.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('Hospital').doc(user.uid).update({
          'Name': hospitalName,
          'ContactInfo': contactInfo,
          'Location': location,
          'BloodStock': bloodStock,
          'DonationRequests': [],
        });

        onSuccess();
      }
    } catch (e) {
      _setLoading(false);
      onError('Failed to save profile: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  //This can be a helper function to update blood stock specifically, as it might be updated separately.
  Future<void> updateBloodStock({
  required Map<String, int> bloodStock,
}) async {
  try {
    _setLoading(true);
    final user = _auth.currentUser;

    if (user == null) {
      SnackbarService.showSnackbar('Not logged in');
      return;
    }
    if (bloodStock.values.every((v) => v == 0)) {
    SnackbarService.showSnackbar('Please enter at least one blood unit.');
    return;
  }

    await FirebaseFirestore.instance
        .collection('Hospital')
        .doc(user.uid)
        .update({'BloodStock': bloodStock});

    SnackbarService.showSnackbar('Blood stock updated successfully!');
    NavigationService.navigateToNamed('/home');

  } catch (e) {
    SnackbarService.showSnackbar('Failed to update: $e');
  } finally {
    _setLoading(false);
  }
}

  //Fetch User or Hospital Data
  Future<Map<String, dynamic>?> fetchProfileData({required String role}) async {
    try {
      _setLoading(true);
      User? user = _auth.currentUser;

      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection(role).doc(user.uid).get();
        _setLoading(false);
        return doc.data();
      }
    } catch (e) {
      _setLoading(false);
      debugPrint('Failed to fetch profile data: $e');
    }
    return null;
  }

  //Form Validation Helper
  String? validateField(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Please enter $fieldName.';
    }
    return null;
  }

  Future<void> _handlePostLogin(User user) async {
  _setLoading(true);
  final userDoc = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
  final hospitalDoc = await FirebaseFirestore.instance.collection('Hospital').doc(user.uid).get();

  if (user.emailVerified) {
    if (userDoc.exists || hospitalDoc.exists) {
      final doc = userDoc.exists ? userDoc : hospitalDoc;
      currentProfile = doc.data();
      currentRole = userDoc.exists ? 'User' : 'Hospital';

      if (currentProfile?['Name'] != null && currentProfile?['Name'] != '') {
        _setLoading(false);
        NavigationService.navigateToReplacement(const HomeScreen());
      } else {
        await saveFcmToken();
        _setLoading(false);
        if (currentRole == 'User') {
          NavigationService.navigateToReplacement(const UserProfileSetupPage());
        } else {
          NavigationService.navigateToReplacement(const HospitalProfileSetupPage());
        }
      }
    } else {
      _setLoading(false);
      SnackbarService.showSnackbar('User document does not exist.');
    }
  } else {
    _setLoading(false);
    NavigationService.navigateToReplacement(
      EmailVerificationScreen(
        user: user,
        email: user.email ?? '',
        selectedRole: userDoc.exists ? 'User' : 'Hospital',
      ),
    );
    notifyListeners();
  }
}

  void logout() async {
    _setLoading(true);
    await _auth.signOut();
    notifyListeners();
    _setLoading(false);
    NavigationService.navigateToReplacementNamed('/login');
  }

Future<void> createBloodRequest({
  required int amount,
  required String bloodGroup,
  required String location,
  required bool isCritical,
  required DateTime requiredDate,
}) async {
  try {
    _setLoading(true);
    final user = _auth.currentUser;
    if (user == null) {
      SnackbarService.showSnackbar('You must be logged in to request blood.');
      _setLoading(false);
      return;
    }

    await FirebaseFirestore.instance.collection('DonationRequests').add({
      'amount': amount,
      'bloodGroup': bloodGroup,
      'location': location,
      'isCritical': isCritical,
      'requiredDate': Timestamp.fromDate(requiredDate),
      'createdAt': Timestamp.now(),
      'requesterId': user.uid,
    });

    SnackbarService.showSnackbar('Request submitted successfully!');
  } catch (e) {
    SnackbarService.showSnackbar('Error submitting request: $e');
  } finally {
    _setLoading(false);
  }
  NavigationService.navigateToNamed('/home');
}
  Future<void> updateBloodRequest({
    required String requestId,
    required int amount,
    required String bloodGroup,
    required String location,
    required bool isCritical,
    required DateTime requiredDate,
  }) async {
    try {
      _setLoading(true);
      final user = _auth.currentUser;
      if (user == null) {
        SnackbarService.showSnackbar('You must be logged in to update a request.');
        _setLoading(false);
      }

      await FirebaseFirestore.instance.collection('DonationRequests').doc(requestId).update({
        'amount': amount,
        'bloodGroup': bloodGroup,
        'location': location,
        'isCritical': isCritical,
        'requiredDate': Timestamp.fromDate(requiredDate),
      });

      SnackbarService.showSnackbar('Request updated successfully!');
    } catch (e) {
      SnackbarService.showSnackbar('Error updating request: $e');
    } finally {
      _setLoading(false);
    }
    NavigationService.navigateToNamed('/home');
  }

Future<void> initChat(String otherUserId) async {
  final me = _auth.currentUser!;
  final ids = [me.uid, otherUserId]..sort();
  final chatDoc = FirebaseFirestore.instance.collection('Chat').doc(ids.join('_'));

  await chatDoc.set({
    'participants': ids,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

Future<void> sendChatMessage({
  required String otherUserId,
  required String text,
}) async {
  final me = _auth.currentUser!;
  final ids = [me.uid, otherUserId]..sort();
  final chatDoc = FirebaseFirestore.instance.collection('Chat').doc(ids.join('_'));

  await chatDoc.set({
    'participants': ids,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

  final userDoc = await FirebaseFirestore.instance.collection('User').doc(me.uid).get();
  final senderName = userDoc.get('Name') ?? '';

  await chatDoc
    .collection('messages')
    .add({
      'text': text,
      'senderId': me.uid,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
    });
}

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'network-request-failed':
        return 'Check your internet...';
      case 'user-disabled':
        return 'User corresponding to the given email has been disabled.';
      case 'too-many-requests':
        return 'You tried too many times.\n Try again later.';
      case 'user-token-expired':
        return 'You are no longer authenticated since your refresh token has been expired.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Please log in.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return 'Invalid Credentials\nYou have account?';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
 }*/