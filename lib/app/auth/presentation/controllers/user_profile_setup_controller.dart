import 'package:flutter/material.dart';
import '../../data/models/model.dart';
import '../../data/models/user_model.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/errors/validation_errors.dart';

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

void saveProfile(BuildContext context) async {
  final isValid = ValidationErrors.validateUserSetup(
  formKey: formKey,
  nameController: nameController,
  contactController: contactController,
  locationController: locationController,
  selectedBloodGroup: selectedBloodGroup,
  selectedGender: selectedGender,
  context: context,
  );
  if (!isValid) return;


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