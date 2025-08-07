import 'package:flutter/material.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/hospital_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/services/custom_dialog_service.dart';
import '../../data/datasource/auth_remote_datasource.dart';
import '../../../../core/utils/errors/app_errors.dart';
import '../../../../core/utils/success/success_messages.dart';

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
          SnackbarService.showSnackbar(AppErrors.getMessage(NavigationService.navigatorKey.currentContext!, 'user_null'));
          return;
        }

        generalModel.fromJson({'Uid': userCredential.user!.uid});
        startLoading();
        await _remote.initialInfoSave(); // Save role info in Firestore
        if (await _sendVerificationEmail() == false) {
          stopLoading();
          return;
        }

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
      (sucess) async {
        stopLoading();
        CustomDialogService.showCustomDialog(
          title: SuccessMessages.success('email_sent_title'),
          content: SuccessMessages.success('reset_email_sent_message'),
        );
      },
    );
  }

  Future<void> checkVerificationStatus(BuildContext context) async {
    startLoading();
      
    if (await _remote.checkVerificationStatus() == true) {
      // Update the general model with verification status
      generalModel.fromJson({
        'IsVerified': true,
        'VerificationTimestamp': DateTime.now().toIso8601String(),
      });
      final result = await _remote.updateProfile(generalModel.toJson());

      await result.fold(
        (error) async {
          stopLoading();
          SnackbarService.showSnackbar(error);
        },
        (success) async {
          stopLoading();
          await CustomDialogService.showCustomDialog(
            title: SuccessMessages.success('verified_title'),
            content: SuccessMessages.success('verified_subtitle'),
          );
       
          if (generalModel.role == 'Hospital') {
            NavigationService.navigateToReplacementNamed('/hospital-profile-setup');
          } 
          else {
            NavigationService.navigateToReplacementNamed('/user-profile-setup');
          }
        }
      );
    }  
    else {
      stopLoading();
      CustomDialogService.showCustomDialog(
        title: SuccessMessages.success('not_verified_title'),
        content: SuccessMessages.success('not_verified_subtitle'),
        );
      }
    }

Future<bool> _sendVerificationEmail() async {
    startLoading();
    
    try {
      await generalModel.userCredential?.user!.sendEmailVerification();
      stopLoading();
      SnackbarService.showSnackbar(SuccessMessages.success('email_verification_sent'));
      return true;
    } catch (e) {
      stopLoading();
      SnackbarService.showSnackbar(AppErrors.getMessage(NavigationService.navigatorKey.currentContext!, e.toString()));
      return false;
    }
  }

  Future<void> resendVerificationEmail() async {
   if(await _sendVerificationEmail() == false){
    return;
   }
  }

  Future<void> saveProfile(Map<String, dynamic> data) async {
    startLoading();
    final result = await _remote.updateProfile(data);
      
    await result.fold(
      (errorCode) async {
        stopLoading();
        SnackbarService.showSnackbar(AppErrors.getMessage(NavigationService.navigatorKey.currentContext!,"failed_to_update_profile") + errorCode);
      },
      (success) async {
        stopLoading();
        SnackbarService.showSnackbar(SuccessMessages.success('profile_updated'));
        NavigationService.navigateToReplacementNamed('/home');
      }
    );
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