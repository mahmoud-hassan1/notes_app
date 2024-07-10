import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/core/widgets/snackbar.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:notes_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/auth/presentation/views/signup_view.dart';
import 'package:notes_app/features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:notes_app/core/widgets/custtom_text_field.dart';
import 'package:notes_app/features/home/presentation/views/home_view.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
      final firebaseAuth = FirebaseAuth.instance;
  final authRepository = AuthRepositoryImpl(firebaseAuth: firebaseAuth);
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AuthCubit(authRepository),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            isLoading = true;
          } else if (state is AuthError) {
           snackBar(content: state.message, context: context);
            isLoading=false;
          } else if (state is AuthAuthenticated) {
            
            snackBar(content: "Login Success", context: context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomeView(uid: state.user.uid,),
                ));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: height / 4),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: FontStyles.kLargeTextStyle(context),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextField(
                      label: "Email",
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextField(
                      label: "Password",
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomButton(
                      emailController: emailController,
                      passwordController: passwordController,
                      onTap: () => BlocProvider.of<AuthCubit>(context)
                          .loginUser(
                              emailController.text, passwordController.text),
                      height: height,
                      label: "LOGIN",
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an account?",
                          style: FontStyles.kSmallTextStyle(context),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupView(),
                                ));
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: Text("Sign up",
                              style: FontStyles.kSmallTextStyle(context)
                                  .copyWith(color: AppColors.kMintGreen)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
