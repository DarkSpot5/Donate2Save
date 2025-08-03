// lib/app/dashboard/presentation/controllers/home_controller.dart
import 'package:donate2save/app/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/snackbar_service.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/model.dart';

class HomeController extends ChangeNotifier {
  
  final AuthController authController;

  HomeController(this.authController);

  final generalModel = Model();
  final searchController = TextEditingController();
  String searchQuery = '';

  String get name => generalModel.name!;
  
  void checkNotifications(BuildContext context) {
    SnackbarService.showSnackbar(S.of(context).noNotifications);
  }
  void updateSearch(String val) {
    searchQuery = val;
    notifyListeners();
  }

  void logout() {
   authController.logout(); 
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}