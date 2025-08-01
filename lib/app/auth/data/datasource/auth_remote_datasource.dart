import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../models/model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  final generalModel = Model(); 

  Future<Either<String, UserCredential>> createProfile(String email, String password) async{
    try{
      final userCred = await _auth.createUserWithEmailAndPassword(email: email,password: password,);
      return Right(userCred); // Success
    } on FirebaseAuthException catch (e) {
      return Left(e.code); // Return error code
    }catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}'); // General error
    }
  }

  Future<void> initialInfoSave() async {
    await FirebaseFirestore.instance.collection(generalModel.role.toString()).doc(generalModel.uid).set({
          'Email': generalModel.email,
          'Role': generalModel.role,
          'isVerified': generalModel.isVerified,
        });
  }
/*
  Future<UserCredential> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  */
  Future<void> sendResetEmail(String email) {
    throw _auth.sendPasswordResetEmail(email: email);
  }

Future<bool> checkVerificationStatus() async {
      await Future.delayed(const Duration(seconds: 2));
      await generalModel.userCredential?.user!.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
      return true; // Email is verified
      } else {
        return false; // Email is not verified
      }
    }

  Future<void>updateProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection(generalModel.role.toString()).doc(user.uid).update(data);
    }
  }
/*
  Future<void> updateUserFcmToken() async {
    final user = _auth.currentUser;
    final token = await FirebaseMessaging.instance.getToken();
    if (user != null && token != null) {
      await _firestore.collection('User').doc(user.uid).update({'fcmToken': token});
    }
  }

  Future<Map<String, dynamic>?> fetchProfile(String role) async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection(role).doc(user.uid).get();
      return doc.data();
    }
    return null;
  }

  Future<void> saveUserProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('User').doc(user.uid).update(data);
    }
  }

  Future<void> saveHospitalProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('Hospital').doc(user.uid).update(data);
    }
  }

  Future<void> updateBloodStock(Map<String, int> bloodStock) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('Hospital').doc(user.uid).update({'BloodStock': bloodStock});
    }
  }

  Future<void> createRequest(Map<String, dynamic> requestData) {
    return _firestore.collection('DonationRequests').add(requestData);
  }

  Future<void> updateRequest(String requestId, Map<String, dynamic> data) {
    return _firestore.collection('DonationRequests').doc(requestId).update(data);
  }

  Future<void> createChat(String otherUserId) async {
    final me = _auth.currentUser!;
    final ids = [me.uid, otherUserId]..sort();
    final docId = ids.join('_');
    await _firestore.collection('Chat').doc(docId).set({
      'participants': ids,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> sendChatMessage(String otherUserId, String text, String senderName) async {
    final me = _auth.currentUser!;
    final ids = [me.uid, otherUserId]..sort();
    final docId = ids.join('_');
    final chatDoc = _firestore.collection('Chat').doc(docId);

    await chatDoc.set({
      'participants': ids,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await chatDoc.collection('messages').add({
      'text': text,
      'senderId': me.uid,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot> getUserDoc() {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('User').doc(uid).get();
  }

  Future<DocumentSnapshot> getHospitalDoc() {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('Hospital').doc(uid).get();
  }

  Future<void> signOut() => _auth.signOut();
*/
}