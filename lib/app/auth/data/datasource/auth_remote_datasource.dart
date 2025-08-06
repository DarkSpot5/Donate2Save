import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../models/model.dart';
import '../../../../core/utils/error_messages.dart';

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
      final friendlyMessage = ErrorMessages.firebase(e.code);
      return Left(friendlyMessage);
    }catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}'); // General error
    }
  }

  Future<void> initialInfoSave() async {
    await FirebaseFirestore.instance.collection(generalModel.role.toString()).doc(generalModel.uid).set(generalModel.toJson());
  }

  Future<Either<String, UserCredential>> login(String email, String password) async {
    try{
      final userCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return Right(userCred); // Success
    } on FirebaseAuthException catch (e) {
      return Left(e.code); // Return error code
    } catch (e) {
      return Left('An unexpected error occurred: ${e.toString()}'); // General error
    }
  }

  Future<String> roleCheck() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('User').doc(user.uid).get();
      final hospitalDoc = await _firestore.collection('Hospital').doc(user.uid).get();

      if (userDoc.exists || hospitalDoc.exists) {
        return userDoc.exists ? 'User' : 'Hospital';
      }
      else {
        return "User document does not exist.";
      }
    }
    else{
    return 'User is null';
    }
    }
  Future<Either<String, String>> screenToNavigate(User user) async {
      
    if (user.emailVerified) {
      final role = await roleCheck();
      if (role == 'User' || role == 'Hospital') {
        final profileData = await fetchProfile(role);
        final name = profileData?['Name']; 

        if (name != null) {
          return Right('/home'); // Navigate to HomeScreen
        } 
        else {
          return Right(role == 'User' ? '/user-profile-setup' : '/hospital-profile-setup');
          }
      } 
      else {
        return Left(role);  // Return error message if role is not User or Hospital
      }
    } else {
      return Right('/email-verification'); // Navigate to email verification screen
    }
  }
  
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

  Future<Map<String, dynamic>?> fetchProfile(String role) async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection(role).doc(user.uid).get();
      return doc.data();
    }
    return null;
  }
/*
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

  Future<DocumentSnapshot> getUserDoc() {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('User').doc(uid).get();
  }

  Future<DocumentSnapshot> getHospitalDoc() {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('Hospital').doc(uid).get();
  }
*/
  Future<void> signOut() => _auth.signOut();
}