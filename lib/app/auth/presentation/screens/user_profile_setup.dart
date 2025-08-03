import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_profile_setup_controller.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';

class UserProfileSetupPage extends StatelessWidget {
  const UserProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserProfileSetupController>(context);

    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Setup Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              tooltip: S.of(context).languageToggle,
              onPressed: () {
                Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
              },
            )
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      const SizedBox(height: 20),

                      // User Name Field
                      TextFormField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      
                      const SizedBox(height: 16),

                      // Contact Number Field
                      TextFormField(
                        controller: controller.contactController,
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      
                      const SizedBox(height: 16),

                      // Blood Group Dropdown
                      DropdownButtonFormField<String>(
                        value: controller.selectedBloodGroup,
                        isExpanded: true,
                        items: <String>[
                          'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
                        ].map((String bloodType) {
                          return DropdownMenuItem<String>(
                            value: bloodType,
                            child: Text(bloodType),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.updateBloodType(newValue);
                        },
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                          labelStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.bloodtype),
                        ),
                      ),
                      
                    const SizedBox(height: 16),

                      // Location Field
                      TextFormField(
                        controller: controller.locationController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    
                    const SizedBox(height: 16),

                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Gender"),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: controller.selectedGender,
                            onChanged: controller.updateGender,
                          ),
                          const Text('Male'),
                          Radio<String>(
                            value: 'Female',
                            groupValue: controller.selectedGender,
                            onChanged: controller.updateGender,
                          ),
                          const Text('Female'),
                          Radio<String>(
                            value: 'Other',
                            groupValue: controller.selectedGender,
                            onChanged: controller.updateGender,
                          ),
                          const Text('Other'),
                        ],
                      ),
                    ],
                  ),

                    const SizedBox(height: 30),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.saveProfile(context);
                          },
                          child: const Text('Save Profile', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}