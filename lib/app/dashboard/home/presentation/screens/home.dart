import 'package:donate2save/app/dashboard/home/presentation/controllers/home_controller.dart';
//import 'package:intl/intl.dart';
//import 'package:donate2save/screens/blood_request_form.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../controllers/home_controller.dart';
//import '../../../../../core/widgets/loading_spinner.dart'; // uses CustomLoader internally
import '../../../../../core/widgets/loading_overlay.dart';

import '../../../../../providers/locale_providers.dart' as langprovider;
import '../../../../../generated/l10n.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    //final isHospital = auth.isHospital;

    return LoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
      title: Text(
        controller.name,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            controller.logout();
          },
        ), 
        IconButton(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).languageToggle,
          onPressed: () {
            Provider.of<langprovider.LocaleProvider>(context, listen: false).toggleLocale();
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            controller.checkNotifications(context);
          },
        ),
      ],
    ),
/*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          NavigationService.navigateTo(RequestBloodPage());
        },
        icon: const Icon(Icons.bloodtype),
        label: const Text('Request Blood'),
        backgroundColor: Colors.redAccent,
      ),
  
        body: isHospital ? Column(
        children: [
          Expanded(child: _buildHospitalInventory(context)),
          const Divider(),
          Expanded(child: _buildRequestList(uid)),
        ],
      ) : Column(
  children: [
    Expanded(child: _buildUserSearchView(context)),
    const Divider(),
    Expanded(child: _buildRequestList(uid)),
    ],
  ),
  */
  ),
);
}
/*
Widget _buildUserSearchView(BuildContext context) {
  final controller = Provider.of<HomeController>(context);
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: S.of(context).searchHint,
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: controller.updateSearch,
        ),
        const SizedBox(height: 20),
        Expanded(child: _hospitalListStream(controller.searchQuery)),
      ],
    ),
  );
}

Widget _hospitalListStream(String query) {
  final snap = FirebaseFirestore.instance
      .collection('Hospital')
      .orderBy('Name')
      .where('Name', isGreaterThanOrEqualTo: query)
      .where('Name', isLessThanOrEqualTo: query + '\uf8ff');

  return StreamBuilder<QuerySnapshot>(
    stream: snap.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text(snapshot.error.toString()));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CustomLoader();
      }

    final docs = snapshot.data!.docs;
      if (docs.isEmpty) {
        return const Center(child: Text('No Hospitals Found'));
      }

     return ListView(
      children: docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
              title: Text(data['Name']),
              subtitle: Text('Blood Inv: ${_formatBlood(data['BloodStock'])}'),
              onTap: () => _goToHospitalProfile(doc.id),
            ),
          );
        }).toList(),
      );
    },
  );
}

  Widget _buildHospitalInventory(BuildContext context) {
  final auth = Provider.of<AuthController>(context, listen: false);
  final docRef = FirebaseFirestore.instance.collection('Hospital').doc(auth.uid);

  return StreamBuilder<DocumentSnapshot>(
    stream: docRef.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
      if (snapshot.connectionState == ConnectionState.waiting) return const CustomLoader();

      final data = snapshot.data!.data() as Map<String, dynamic>?;
      if (data == null) return const Center(child: Text('No inventory data'));

      final inv = data['BloodStock'] as Map<String, dynamic>;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: inv.entries
                    .map((e) => ListTile(
                          title: Text('${e.key}'),
                          trailing: Text('${e.value} units'),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                NavigationService.navigateToNamed('/update_Stock');
              },
              child: const Text('Update Blood Stock'),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildRequestList(String currentUserId) {
  final snap = FirebaseFirestore.instance
      .collection('DonationRequests')
      .orderBy('createdAt', descending: true);

  return StreamBuilder<QuerySnapshot>(
    stream: snap.snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) return const Center(child: Text('Error loading requests'));
      if (snapshot.connectionState == ConnectionState.waiting) return const CustomLoader();

      final docs = snapshot.data!.docs;
      if (docs.isEmpty) return const Center(child: Text('No requests available'));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('All Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final docId = docs[index].id;
                final requesterId = data['requesterId'];
                final isMine = requesterId == currentUserId;
                final date = (data['requiredDate'] as Timestamp).toDate();
                final critical = data['isCritical'] == true;

                return Card(
                  color: critical ? Colors.red[50] : null,
                  child: ListTile(
                    title: Text('${data['bloodGroup']} - ${data['amount']} units'),
                    subtitle: Text('${data['location']} • ${DateFormat.yMMMd().format(date)}'),
                    trailing: isMine
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {
                                  final requestData = {...data, 'id': docId};
                                  NavigationService.navigateToNamed('/edit_request', arguments: requestData);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.grey),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('DonationRequests')
                                      .doc(docId)
                                      .delete();
                                },
                              ),
                            ],
                          )
                        : IconButton(
                            icon: const Icon(Icons.chat),
                            tooltip: 'Open Chats',
                            onPressed: () => Navigator.pushNamed(context, '/chats'),
                          ),
                          ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
  String _formatBlood(Map inv) {
    return inv.entries.map((e) => '${e.key}: ${e.value}').join(', ');
  }

  void _goToHospitalProfile(String hospitalId) {
    NavigationService.navigateToNamed('/hospitalProfile', arguments: {'hospitalId': hospitalId});
  }
*/
}