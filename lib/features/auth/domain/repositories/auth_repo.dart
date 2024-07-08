

import 'package:notes_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserClass?> login(String email, String password);
  Future<UserClass?> signup(String email, String password);
}