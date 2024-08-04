

import 'package:notes_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserClass?> login(String email, String password);
  void logout();
  Future<UserClass?> signup(String name,String email, String password);
  Future<void> sendPasswordResetLink(String email);
  Future<UserClass?> loginWithGoogle();
}