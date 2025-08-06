import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../models/model.dart';
import '../../../../core/errors/firebase_errors.dart';

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
      final friendlyMessage = FirebaseErrors.firebase(e.code);
      return Left(friendlyMessage);
    }catch (e) {
      final friendlyMessage = FirebaseErrors.firebase(e.toString());
      return Left(friendlyMessage); // General error
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
      final friendlyMessage = FirebaseErrors.firebase(e.code);
      return Left(friendlyMessage);
    } catch (e) {
      final friendlyMessage = FirebaseErrors.firebase(e.toString());
      return Left(friendlyMessage); // General error
    }
  }

  Future<Either<String, String>> roleCheck() async {
  final user = _auth.currentUser;

  if (user != null) {
    final userDoc = await _firestore.collection('User').doc(user.uid).get();
    final hospitalDoc = await _firestore.collection('Hospital').doc(user.uid).get();

    if (userDoc.exists || hospitalDoc.exists) {
      return Right(userDoc.exists ? 'User' : 'Hospital');  // success
    } else {
      return Left('user_not_found'); // error code
    }
  } else {
    return Left('user_null'); // error code
  }
}

Future<Either<String, String>> decideNavigationRoute(User user) async {

  if (user.emailVerified) {
    final roleResult = await roleCheck(); // Either<String (error), String (role)>

    return await roleResult.fold(
      (errorCode) {
        return Left(errorCode); // e.g., 'user_not_found', 'user_null'
      },
      (role) async {
        if (role == 'User' || role == 'Hospital') {
          final profileData = await fetchProfile(role);
          final name = profileData?['Name'];

          if (name != null) {
            return Right('/home'); // Navigate to HomeScreen
          } else {
            return Right(role == 'User' ? '/user-profile-setup' : '/hospital-profile-setup');
          }
        } else {
          return Left('invalid_role');
        }
      },
    );
  } else {
    return Right('/email-verification');
  }
}
  
  Future<Either<String, String>> sendResetEmail(String email) async {
    try{
      _auth.sendPasswordResetEmail(email: email);
      return Right('Password reset email sent successfully.');
    } on FirebaseAuthException catch (e) {
      final friendlyMessage = FirebaseErrors.firebase(e.code);
      return Left(friendlyMessage);
    } catch (e) {
      final friendlyMessage = FirebaseErrors.firebase(e.toString());
      return Left(friendlyMessage); // General error
    }
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