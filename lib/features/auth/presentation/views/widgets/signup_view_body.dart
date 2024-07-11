import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/core/widgets/snackbar.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:notes_app/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:notes_app/features/auth/presentation/views/login_view.dart';
import 'package:notes_app/features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:notes_app/core/widgets/custtom_text_field.dart';
import 'package:notes_app/features/home/presentation/views/home_view.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupViewBodyState createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
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
            setState(() {
              isLoading = true;
            });
          } else if (state is AuthError) {
              isLoading = false;
           snackBar(content: state.message, context: context);
          } else if (state is AuthAuthenticated) {
              isLoading = false;
            snackBar(content: "Sign up successful!", context: context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  HomeView(
                     uid: state.user.uid,
                  ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Text(
                        "Create Account",
                        style: FontStyles.kLargeTextStyle(context),
                      ),
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
                      onTap: () => BlocProvider.of<AuthCubit>(context).signupUser(
                          emailController.text, passwordController.text),
                      emailController: emailController,
                      passwordController: passwordController,
                      height: height,
                      label: "SIGN UP",
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: FontStyles.kSmallTextStyle(context),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ));
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: Text("Sign in",
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
