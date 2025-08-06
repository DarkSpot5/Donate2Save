import 'package:flutter/material.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../data/models/model.dart';
import '../../data/models/hospital_model.dart';
import '../controllers/auth_controller.dart';
import '../../../../generated/l10n.dart';

class HospitalProfileSetupController extends ChangeNotifier {
  
  final AuthController authController;
  final S localization; // Injected localization

  HospitalProfileSetupController(this.authController, {required this.localization});
  
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

  bool _validateInputs() {
    final form = formKey.currentState;

    if (form == null || !form.validate()) {
      return false; // Built-in form field validation failed
    }
    
    final name = nameController.text.trim();
    if (name.isEmpty) {
      SnackbarService.showSnackbar(localization.errorEnterHospitalName);
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

    final location = locationController.text.trim();
    if (location.isEmpty) {
    SnackbarService.showSnackbar(localization.errorEnterLocation);
    return false;
    }

    for (var entry in bloodControllers.entries) {
      final value = entry.value.text.trim();
      if (value.isEmpty) {
        SnackbarService.showSnackbar(localization.errorEnterBloodStock(entry.key));
        return false;
      }

      final intValue = int.tryParse(value);
      if (intValue == null) {
        SnackbarService.showSnackbar(localization.errorInvalidBloodStock(entry.key));
        return false;
      }

      bloodStock[entry.key] = intValue; // Update from controller
    }

    return true;
  }

  Future<void> saveProfile(BuildContext context) async {
    if (!_validateInputs()) return;

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