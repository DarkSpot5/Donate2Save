import 'package:flutter/material.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../controllers/auth_controller.dart';
import '../../../../generated/l10n.dart';

class UserProfileSetupController extends ChangeNotifier {
 
  final AuthController authController;
  final S localization; // Injected localization

  UserProfileSetupController(this.authController, {required this.localization});

  final generalModel = Model();
  final userModel = UserModel();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final locationController = TextEditingController();
  String selectedBloodGroup = 'A+'; // Default blood type selection
  String? selectedGender;

  
  // Call this when location is picked
  /*void setLocation(String newLocation) {
    location = newLocation;
    notifyListeners();
  }*/

  void updateBloodType(String? newValue) {
    selectedBloodGroup = newValue!;
    notifyListeners();
  }

  void updateGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  bool _validateInputs() {
    final form = formKey.currentState;

    if (form == null || !form.validate()) {
      return false; // Built-in form field validation failed
    }

    if (nameController.text.trim().isEmpty) {
        SnackbarService.showSnackbar(localization.errorEnterName);
        return false;
      }

    final contact = contactController.text.trim();
    if (contact.isEmpty) {
        SnackbarService.showSnackbar(localization.errorEnterContact);
        return false;
      }

    if (!RegExp(r'^\d{11}$').hasMatch(contact)) {
        SnackbarService.showSnackbar(localization.errorInvalidContact);
        return false;
      }

    if (selectedBloodGroup.isEmpty) {
      SnackbarService.showSnackbar(localization.errorSelectBloodGroup);
      return false;
    }

    final location = locationController.text.trim();
    if (location.isEmpty) {
      SnackbarService.showSnackbar(localization.errorEnterLocation);
      return false;
    }
    if (selectedGender == null || selectedGender!.isEmpty) {
      SnackbarService.showSnackbar(localization.errorSelectGender);
      return false;
    }

    return true; // All validations passed
  }

void saveProfile(BuildContext context) async {
  if (!_validateInputs()) return;

  generalModel.fromJson({
    'Name': nameController.text.trim(),
    'Contact': contactController.text.trim(),
    'Location': locationController.text.trim(),});
  userModel.fromJson({
    'BloodGroup': selectedBloodGroup,
    'Gender': selectedGender});

  authController.saveProfile(generalModel.toJson()..addAll(userModel.toJson()));
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    locationController.dispose();
    super.dispose();
  }
}