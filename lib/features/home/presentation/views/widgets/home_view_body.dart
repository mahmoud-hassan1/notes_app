import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/features/auth/presentation/views/login_view.dart';

import 'package:notes_app/features/home/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 16),
      child:  CustomScrollView(
        slivers:[
          SliverFillRemaining(
           child:  Column(
          children: [
            AppBar(
              actions: [IconButton(icon: const Icon(Icons.exit_to_app,color: Colors.white,),onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView(),));
          },),],
            backgroundColor: AppColors.kBackgroundColor,
            title: const Text(
              "Notes",
            ),
            elevation: 0,
            centerTitle: true,
          ),
          
           const CustomListView()
          ],
        ),
          )
        ], 
      ),
      
    );
  }
}


