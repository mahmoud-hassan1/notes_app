import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:notes_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
      final firebaseAuth = FirebaseAuth.instance;
  final authRepository = AuthRepositoryImpl(firebaseAuth: firebaseAuth);
    return BlocProvider(
      create: (context) => AuthCubit(authRepository),
      child: Scaffold(
        body: ResetPasswordViewBody(),
      ),
    );
  }
}
