import 'package:donate2save/core/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/hospital_profile_setup_controller.dart';
import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../generated/l10n.dart';

class HospitalProfileSetupPage extends StatelessWidget {
  const HospitalProfileSetupPage({super.key});

  Widget _buildBloodStockFields(BuildContext context) {
    final controller = Provider.of<HospitalProfileSetupController>(context);
    return Column(
      children: controller.bloodStock.keys.map((bloodType) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  bloodType,
                  style: const TextStyle(fontSize: 16, color: Colors.black), // Blood type label
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.bloodControllers[bloodType],
                  onTap: () {
                    if (controller.bloodControllers[bloodType]!.text == '0') {
                      controller.bloodControllers[bloodType]!.clear();
                    }
                  },
                  onChanged: (value) {
                  controller.updateStock(bloodType, value.isEmpty ? '0' : value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Quantity', // Hint always visible initially
                  ),
                  style: const TextStyle(color: Colors.black), // Black text color
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HospitalProfileSetupController>(context);
    return LoadingOverlay(child:
     Scaffold(
        appBar: AppBar(title: const Text('Setup Profile'),
        actions: [ 
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).languageToggle,
          onPressed: () {
            Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
          },
        )
      ]),
      
          body: Stack(
            children: [
            // Main content with scrolling
            SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(30.0),
             child: Form(
             key: controller.formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [

              const SizedBox(height: 20),
              
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Hospital Name',
                  prefixIcon: const Icon(Icons.local_hospital),
                ),
                style: const TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 16),
              
              TextFormField(
                controller: controller.contactController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: const Icon(Icons.contact_phone),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              
              const SizedBox(height: 16),
              
              // Location Field
              TextFormField(
                controller: controller.locationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: const Icon(Icons.location_on),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              
              const SizedBox(height: 16),
              
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Initial Blood Stock',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              _buildBloodStockFields(context),
              
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity, //Ensures button width is full.
                 child: ElevatedButton(
                onPressed:() { 
                  controller.saveProfile(context);
                  },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ), 
                child: const Text('Save Profile', style: TextStyle(fontSize: 18)),
              ),
            ),
            ],
           )
          ),
        )
        ),
      ]
     )
    )
    );
  }
}