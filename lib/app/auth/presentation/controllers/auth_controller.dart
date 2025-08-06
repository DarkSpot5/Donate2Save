import 'package:flutter/material.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/hospital_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/customDialog_service.dart';
import '../../data/datasource/auth_remote_datasource.dart';
import '../../../../core/errors/app_errors.dart';

class AuthController extends ChangeNotifier {
  final AuthRemoteDataSource _remote = AuthRemoteDataSource();

  final generalModel = Model();
  final userModel = UserModel();
  final hospitalModel = HospitalModel();
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> register(String password) async {
    startLoading();
    
    final result = await _remote.createProfile(generalModel.email.toString(), password);

    await result.fold(
      (failuremessage) async{
        stopLoading();
        SnackbarService.showSnackbar(failuremessage);
      },

      (userCredential) async{
        generalModel.userCredential = userCredential;

        if (userCredential.user == null) {
          stopLoading();
          SnackbarService.showSnackbar('User not found after registration.');
          return;
        }

        generalModel.fromJson({'Uid': userCredential.user!.uid});
        startLoading();
        await _remote.initialInfoSave(); // Save role info in Firestore
        generalModel.userCredential?.user!.sendEmailVerification();

        // Navigate to email verification screen with role
        stopLoading();
        await NavigationService.navigateToNamed('/email-verification');});
  }

  Future<void> login(String email, String password, BuildContext context) async {
    startLoading();
      
      final result = await _remote.login(email, password);
      
      await result.fold(
        (failureMessage) async {
          stopLoading();
          SnackbarService.showSnackbar(failureMessage);
        },
        (userCred) async {
          generalModel.userCredential = userCred;
          generalModel.fromJson({'Email': email, 'Uid': userCred.user!.uid});
          await _handlePostLogin(context);
          stopLoading();
        },
      );
    }

  Future<void> _handlePostLogin(BuildContext context) async {
    startLoading();
    final result = await _remote.decideNavigationRoute(generalModel.userCredential!.user!);
    
    await result.fold(
      (errorCode) async {
        stopLoading();
        SnackbarService.showSnackbar(AppErrors.getMessage(context, errorCode));
      },
      (navigationScreen) async {
          stopLoading();
         await NavigationService.navigateToReplacementNamed(navigationScreen);
      },
    );
    stopLoading();
  }

  Future<void> sendResetEmail(String email) async {
    
    startLoading();
    final result = await _remote.sendResetEmail(email);

    await result.fold(
      (failureMessage) async {
        stopLoading();
        SnackbarService.showSnackbar(failureMessage);
      },
      (successMessage) async {
        stopLoading();
        CustomDialogService.showCustomDialog(
          title: "Email Sent",
          content: successMessage,
        );
      },
    );
  }

  Future<void> checkVerificationStatus() async {
    startLoading();
      
    if (await _remote.checkVerificationStatus() == true) {
      // Update the general model with verification status
      generalModel.fromJson({
        'IsVerified': true,
        'VerificationTimestamp': DateTime.now().toIso8601String(),
      });
      
      await _remote.updateProfile(generalModel.toJson());
      stopLoading();
      await CustomDialogService.showCustomDialog(
      title: 'Verified',
      content: 'Your email has been successfully verified.');
       
        if (generalModel.role == 'Hospital') {
          NavigationService.navigateToReplacementNamed('/hospital-profile-setup');
        } else {
          NavigationService.navigateToReplacementNamed('/user-profile-setup');
        }
      } else {
        stopLoading();
        CustomDialogService.showCustomDialog(
          title: 'Email Not Verified',
          content: 'Your email is not verified. Please verify your email and try again.',
        );
      }
    }

  Future<void> resendVerificationEmail() async {
    
    try {
      startLoading();
      await generalModel.userCredential?.user!.sendEmailVerification();
      stopLoading();
      SnackbarService.showSnackbar('Verification email has been resent.');
    } catch (e) {
      SnackbarService.showSnackbar('Error: ${e.toString()}');
    } finally {
      stopLoading();
    }
  }

  Future<void> saveProfile(Map<String, dynamic> data) async {

    try {
      startLoading();
      await _remote.updateProfile(data);
      stopLoading();
      SnackbarService.showSnackbar('Profile updated successfully.');
      NavigationService.navigateToReplacementNamed('/home');
    } catch (e) {
      stopLoading();
      SnackbarService.showSnackbar('Failed to update profile: ${e.toString()}');
    } finally {
      stopLoading();
    }
  }

  void logout() async {
    startLoading();
    generalModel.reset();
    userModel.reset();
    hospitalModel.reset();

    await _remote.signOut();

    stopLoading();
    NavigationService.navigateToReplacementNamed('/login');
  }
}