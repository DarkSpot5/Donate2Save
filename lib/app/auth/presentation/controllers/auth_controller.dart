import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../generated/l10n.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/utils/error_messages.dart';
import '../../../../core/services/navigation_service.dart';
import '../../data/datasource/auth_remote_datasource.dart';
import '../controllers/email_verification_controller.dart';
import '../../../auth/presentation/screens/email_verification.dart';

class AuthController with ChangeNotifier {
  final AuthRemoteDataSource _remote = AuthRemoteDataSource();

  final generalModel = Model();
  final userModel = UserModel();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? currentProfile;
  String? currentRole;

  String get uid => generalModel.uid ?? _remote.currentUser?.uid ?? '';

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  Future<void> register(String password) async {
    _setLoading(true);
    
    final result = await _remote.createProfile(generalModel.email.toString(), password);

    await result.fold(
      (failuremessage) async{
        _setLoading(false);
        SnackbarService.showSnackbar(ErrorMessages.firebase(failuremessage));
      },

      (userCredential) async{
        generalModel.userCredential = userCredential;

        if (userCredential.user == null) {
          SnackbarService.showSnackbar('User not found after registration.');
          return;
        }

        generalModel.uid = userCredential.user!.uid;
        await _remote.initialInfoSave(); // Save role info in Firestore
        userCredential.user!.sendEmailVerification();

        // Navigate to email verification screen with role
        await NavigationService.navigateToNamed('/email-verification');});

  _setLoading(false);
}
/*
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      SnackbarService.showSnackbar('Email and password must not be empty.');
      return;
    }

    try {
      _setLoading(true);
      final userCred = await _remote.login(email, password);
      final user = userCred.user;
      if (user != null) {
        await _handlePostLogin(user);
      }
    } catch (e) {
      final code = (e as dynamic).code ?? '';
      SnackbarService.showSnackbar(ErrorMessages.firebase(code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _handlePostLogin(User user) async {
    _setLoading(true);
    final userDoc = await _remote.getUserDoc();
    final hospitalDoc = await _remote.getHospitalDoc();

    if (user.emailVerified) {
      if (userDoc.exists || hospitalDoc.exists) {
        final doc = userDoc.exists ? userDoc : hospitalDoc;
        currentProfile = doc.data() as Map<String, dynamic>?;
        currentRole = userDoc.exists ? 'User' : 'Hospital';

        if ((currentProfile?['Name'] ?? '').toString().isNotEmpty) {
          NavigationService.navigateToReplacement(const HomeScreen());
        } else {
          await _remote.updateUserFcmToken();
          if (currentRole == 'User') {
            NavigationService.navigateToReplacement(const UserProfileSetupPage());
          } else {
            NavigationService.navigateToReplacement(const HospitalProfileSetupPage());
          }
        }
      } else {
        SnackbarService.showSnackbar('User document does not exist.');
      }
    } else {
      NavigationService.navigateToReplacement(
        EmailVerificationScreen(),
      );
    }
    _setLoading(false);
  }
*/
  Future<void> sendResetEmail(String email, BuildContext context) async {
    
    try {
      _setLoading(true);
      await _remote.sendResetEmail(email);
      
      NavigationService.showCustomDialog(
        title: S.of(context).emailSentTitle,
        content: S.of(context).resetEmailSent(email),
      );
    } catch (e) {
      final code = (e as dynamic).code ?? '';
      SnackbarService.showSnackbar(ErrorMessages.firebase(code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkVerificationStatus() async {
    _setLoading(true);
      
    if (await _remote.checkVerificationStatus() == true) {
      // Update the general model with verification status
      generalModel.isVerified = true;
      generalModel.verificationTimestamp = DateTime.now();
      
      await _remote.updateProfile({
        'isVerified': true,
        'verificationTimestamp': generalModel.verificationTimestamp,
      });
      await NavigationService.showCustomDialog(
      title: 'Verified',
      content: 'Your email has been successfully verified.');
       
        if (generalModel.role == 'Hospital') {
          NavigationService.showCustomDialog(
          title: 'Welcome Hospital',
          content: 'Your hospital profile is ready.',
          );
          //NavigationService.navigateToReplacement(const HospitalProfileSetupPage());
        } else {
          NavigationService.showCustomDialog(
          title: 'Welcome User',
          content: 'Your user profile is ready.',
          );
          //NavigationService.navigateToReplacement(const UserProfileSetupPage());
        }
      } else {
        NavigationService.showCustomDialog(
          title: 'Email Not Verified',
          content: 'Your email is not verified. Please verify your email and try again.',
        );
      }
    _setLoading(false);
    }

  Future<void> resendVerificationEmail() async {
    
    try {
      _setLoading(true);
      await generalModel.userCredential?.user!.sendEmailVerification();
      SnackbarService.showSnackbar('Verification email has been resent.');
    } catch (e) {
      SnackbarService.showSnackbar('Error: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
/*
  void logout() async {
    _setLoading(true);
    await _remote.signOut();
    _setLoading(false);
    NavigationService.navigateToReplacementNamed('/login');
  }*/
}