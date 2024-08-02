// File: home_view_body.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repo_imp.dart';
import 'package:notes_app/features/auth/presentation/views/login_view.dart';
import 'package:notes_app/features/home/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatelessWidget {
   HomeViewBody({super.key, required this.scrollController, required this.showFabNotifier});
  final ScrollController scrollController;
  final ValueNotifier<bool> showFabNotifier;
  final firebaseuser=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    AuthRepositoryImpl(firebaseAuth: FirebaseAuth.instance).logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginView()),
                    );
                  },
                ),
              ],
              backgroundColor: AppColors.kBackgroundColor,
              title:  Text(
                "Welcome ${firebaseuser!.displayName}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),
              ),
              elevation: 0,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                 Padding(
                   padding: const EdgeInsets.only(top: 16),
                   child: CustomListView(showFabNotifier: showFabNotifier, scrollController: scrollController,),
                 ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
