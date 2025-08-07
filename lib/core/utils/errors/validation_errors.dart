import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../services/snackbar_service.dart';

class ValidationErrors {
  // Register Form Validation
  bool validateRegister({
    required String email,
    required String password,
    required String confirmPassword,
    required String selectedRole,
    required BuildContext context,
  })
  {
    final localization = S.of(context);

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      SnackbarService.showSnackbar(localization.errorAllFieldsRequired);
      return false;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      SnackbarService.showSnackbar(localization.errorInvalidEmail);
      return false;
    }

    if (password != confirmPassword) {
      SnackbarService.showSnackbar(localization.errorPasswordsDoNotMatch);
      return false;
    }

    if(password.length < 8) {
      SnackbarService.showSnackbar(localization.errorPasswordTooShort);
      return false;
    }

    if(password.contains(RegExp(r'[A-Z]')) && 
       password.contains(RegExp(r'[a-z]')) && 
       password.contains(RegExp(r'[0-9]')) && 
       password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      // Password is strong
    } else {
      SnackbarService.showSnackbar(localization.errorPasswordRequirements);
      return false;
    }

    if (selectedRole.isEmpty) {
      SnackbarService.showSnackbar(localization.errorRoleNotSelected);
      return false;
    }

    return true;
  }

  // Login Validation
  static bool validateLogin(String email, String password, BuildContext context) {
    final localization = S.of(context);

    if (email.isEmpty || password.isEmpty) {
      SnackbarService.showSnackbar(localization.errorAllFieldsRequired);
      return false;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      SnackbarService.showSnackbar(localization.errorInvalidEmail);
      return false;
    }

    return true;
  }
  
  // Forgot Password Validation
  static bool validateForgotPassword(String email, BuildContext context) {
    final localization = S.of(context);

    if (email.isEmpty) {
      SnackbarService.showSnackbar(localization.errorEnterEmail);
      return false;
    }
    
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      SnackbarService.showSnackbar(localization.errorInvalidEmail);
      return false;
    }

    return true;
  }

  // User Setup Validation
  static bool validateUserSetup({
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController contactController,
    required TextEditingController locationController,
    required String selectedBloodGroup,
    required String? selectedGender,
    required BuildContext context,
  }) {
    final localization = S.of(context);

    final form = formKey.currentState;
    if (form == null || !form.validate()) return false;

    final name = nameController.text.trim();
    if (name.isEmpty) {
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

    if (selectedGender == null || selectedGender.isEmpty) {
      SnackbarService.showSnackbar(localization.errorSelectGender);
      return false;
    }

    return true;
  }

  // Hospital Setup Validation
  static bool validateHospitalSetup({
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController contactController,
    required TextEditingController locationController,
    required Map<String, TextEditingController> bloodControllers,
    required Map<String, int> bloodStock,
    required BuildContext context,
  }) {
    final localization = S.of(context);

    final form = formKey.currentState;
    if (form == null || !form.validate()) return false;

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
      final bloodType = entry.key;
      final value = entry.value.text.trim();

      if (value.isEmpty) {
        SnackbarService.showSnackbar(localization.errorEnterBloodStock(bloodType));
        return false;
      }

      final intValue = int.tryParse(value);
      if (intValue == null) {
        SnackbarService.showSnackbar(localization.errorInvalidBloodStock(bloodType));
        return false;
      }

      bloodStock[bloodType] = intValue;
    }

    return true;
  }
}