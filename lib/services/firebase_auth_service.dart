/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surveywebapp/models/user.dart' as User;

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  User.User? _userFromFirebase(User.User user) {
    if (user == null) {
      return null;
    }
    return User.User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }*/
/*
  Stream<User.User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User.User?> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<User.User?> currentUser() async {
    final user = await _firebaseAuth.currentUser!;
    return _userFromFirebase(user);
  }
}*/
