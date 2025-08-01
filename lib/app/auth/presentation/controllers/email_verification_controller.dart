import 'auth_controller.dart';
import '../../../../core/state/loading_controller.dart';
//import '../../../../core/services/snackbar_service.dart';
//import '../../../../core/services/navigation_service.dart';
//import '../../../auth/presentation/screens/user_profile_setup.dart';
//import '../../../auth/presentation/screens/hospital_profile_setup.dart';
import '../../data/models/model.dart';

class EmailVerificationController extends LoadingController {
  final AuthController authController = AuthController();
  final Model generalModel = Model();

  Future<void> checkVerificationStatus() async {
  
    authController.checkVerificationStatus();
      //NavigationService.navigateToReplacement(
        //generalModel.role == 'Hospital'
          //  ? const HospitalProfileSetupPage()
            //: const UserProfileSetupPage(),
      //);
  }

  Future<void> resendVerificationEmail() async {
    authController.resendVerificationEmail();
  }
}