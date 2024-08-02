import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/utiles/app_colors.dart';
import 'package:notes_app/features/auth/presentation/views/login_view.dart';
import 'package:notes_app/features/home/presentation/views/home_view.dart';
import 'package:notes_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.kBackgroundColor ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser==null? const LoginView():HomeView(uid:FirebaseAuth.instance.currentUser!.uid ),
    );
  }
}
