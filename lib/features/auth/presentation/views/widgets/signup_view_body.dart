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

// ignore: must_be_immutable
class SignupViewBody extends StatelessWidget {
   SignupViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> keyForm = GlobalKey();

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
              isLoading = false;
           snackBar(content: state.message, context: context);
          } else if (state is AuthAuthenticated) {
              isLoading = false;
            snackBar(content: "Verfication link sent to your email", context: context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const LoginView(),
                ));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
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
                        controller: nameController,
                        label: "Name",
                        prefixIcon: const Icon(Icons.person_outline_outlined),
                        keyForm: keyForm,
                        validator: (value){
                           if (value!.isEmpty) {
                              return 'Please enter Name';
                            }
                            else{
                              return null;
                            }
                        },
                        expand: false,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomTextField(
                        expand: false,
                          keyForm: keyForm,
                          validator: (value){
                            RegExp regex=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                             if (value!.isEmpty) {
                              return 'Please enter mail';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid mail';
                              } else {
                                return null;
                              }
                              }
                          },
                        prefixIcon: const Icon(Icons.mail_outline),
                        label: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomTextField(
                        expand: false,
                          keyForm: keyForm,
                         validator: (value){
                            RegExp regex =
                                RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid password';
                              } else {
                                return null;
                              }
                         }
                  
                          },
                        password: true,
                        obscure: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        label: "Password",
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                        onTap: () { 
                          if(emailController.text.isNotEmpty&&passwordController.text.isNotEmpty){
                          BlocProvider.of<AuthCubit>(context).signupUser(
                            nameController.text,emailController.text, passwordController.text);
                          }
                          else {
                            snackBar(content: "Please enter Your email and password", context: context);
                          }
                        },
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
            ),
          );
        },
      ),
    );
  }
}
