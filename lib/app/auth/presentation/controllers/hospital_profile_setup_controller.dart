import 'package:flutter/material.dart';
import '../../data/models/model.dart';
import '../../data/models/hospital_model.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/utils/errors/validation_errors.dart';

class HospitalProfileSetupController extends ChangeNotifier {
  
  final AuthController authController;

  HospitalProfileSetupController(this.authController);
  
  final generalModel = Model();
  final hospitalModel = HospitalModel();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final locationController = TextEditingController();

  final Map<String, int> bloodStock = {
    'A+': 0, 'A-': 0, 'B+': 0, 'B-': 0,
    'AB+': 0, 'AB-': 0, 'O+': 0, 'O-': 0,
  };

  final Map<String, TextEditingController> bloodControllers = {
    'A+': TextEditingController(text: '0'),
    'A-': TextEditingController(text: '0'),
    'B+': TextEditingController(text: '0'),
    'B-': TextEditingController(text: '0'),
    'AB+': TextEditingController(text: '0'),
    'AB-': TextEditingController(text: '0'),
    'O+': TextEditingController(text: '0'),
    'O-': TextEditingController(text: '0'),
  };

  // Call this when location is picked
  /*void setLocation(String newLocation) {
    location = newLocation;
    notifyListeners();
  }*/

  void updateStock(String bloodType, String value) {
    bloodStock[bloodType] = int.tryParse(value) ?? 0;
    notifyListeners();
  }

Future<void> saveProfile(BuildContext context) async {
  final isValid = ValidationErrors.validateHospitalSetup(
    formKey: formKey,
    nameController: nameController,
    contactController: contactController,
    locationController: locationController,
    bloodControllers: bloodControllers,
    bloodStock: bloodStock,
    context: context,
  );
  if (!isValid) return;



    generalModel.fromJson({
      'Name': nameController.text.trim(),
      'Contact': contactController.text.trim(),
      'Location': locationController.text.trim(),
    });
    hospitalModel.fromJson({
      'BloodStock': bloodStock,
    });
    authController.saveProfile(generalModel.toJson()..addAll(hospitalModel.toJson()));
  }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    locationController.dispose();
    for (var controller in bloodControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}