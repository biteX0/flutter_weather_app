import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/auth/auth_controller.dart';
import 'package:weather/screens/auth/login_screen.dart';
import 'package:weather/screens/home/home_screen.dart';

class AuthOrLoadingHomeScreen extends GetView<AuthController> {
  const AuthOrLoadingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return HomeScreen();
        } else { 
          return LoginScreen();
        }
      },
        ),
  
    );
  }
}