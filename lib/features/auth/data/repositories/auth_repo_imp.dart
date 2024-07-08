

import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/features/auth/domain/entities/user.dart';
import 'package:notes_app/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override   
  Future<UserClass?> login(String email, String password) async {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
  }

  @override
  Future<UserClass?> signup(String email, String password) async {
   final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
  }
}