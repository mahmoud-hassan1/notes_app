import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/core/utiles/font.dart';
import 'package:notes_app/features/auth/presentation/views/login_view.dart';
import 'package:notes_app/features/auth/presentation/views/widgets/custtom_button.dart';
import 'package:notes_app/features/auth/presentation/views/widgets/custtom_text_field.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
     double height =MediaQuery.of(context).size.height;
     return   SingleChildScrollView(
       child: Padding(
            padding: EdgeInsets.only(top:height/4),
            child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    "Create Account",
                    style: FontStyles.kLargeTextStyle(context),
                  ),
                ),
               const SizedBox(height: 32,),
               const CustomTextField(label: "Email"),
               const SizedBox(height: 32,),
               const CustomTextField(label: "Password"),
               const SizedBox(height: 32,),
               CustomButton(height: height,label: "SIGN UP",),
                const SizedBox(height: 32,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                    "Already have an account?",style: FontStyles.kSmallTextStyle(context),),
                   TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const LoginView(),));
                    },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0)
                        ),
                     child: Text(
                      "Sign in",
                      style:FontStyles.kSmallTextStyle(context).copyWith(
                        color: AppColors.kMintGreen
                        )
                        ),
                        )
                 ],
               ),
              ],
            ),
          ),
    
    );
  }
}