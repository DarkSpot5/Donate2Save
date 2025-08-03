import 'package:flutter/material.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../controllers/auth_controller.dart';

class UserProfileSetupController extends ChangeNotifier {
 
  final AuthController authController;
  UserProfileSetupController(this.authController);

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
        SnackbarService.showSnackbar('Please enter the Name');
        return false;
      }

    final contact = contactController.text.trim();
    if (contact.isEmpty) {
        SnackbarService.showSnackbar('Please enter the Contact Number');
        return false;
      }

    if (!RegExp(r'^\d{11}$').hasMatch(contact)) {
        SnackbarService.showSnackbar('Enter a valid 11-digit Contact Number');
        return false;
      }

    if (selectedBloodGroup.isEmpty) {
      SnackbarService.showSnackbar('Please select your Blood Group');
      return false;
    }

    final location = locationController.text.trim();
    if (location.isEmpty) {
      SnackbarService.showSnackbar('Please insert your Location');
      return false;
    }
    if (selectedGender == null || selectedGender!.isEmpty) {
      SnackbarService.showSnackbar('Please select your Gender');
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