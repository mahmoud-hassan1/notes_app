import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:notes_app/features/auth/domain/entities/user.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepositoryImpl authRepo;
  void loginUser(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.login(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Login failed"));
      }
    } catch (e) {
      if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError(e.toString()));
      }
    }
  }

  void signupUser(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepo.signup(email, password);
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Signup failed"));
      }
    } catch (e) {
     if (e is FirebaseException) {
        emit(AuthError(e.code));
      } else {
        emit(AuthError(e.toString()));
      }
    }
  }
}

