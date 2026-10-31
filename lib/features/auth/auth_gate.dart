import 'package:cubit/features/auth/di/auth_dependencies.dart';
import 'package:cubit/features/auth/presentation/login/view/login.dart';
import 'package:cubit/features/auth/repository/authenticated.dart';
import 'package:cubit/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return  Scaffold(
            body:Center(child: CircularProgressIndicator(),)
          );
          
        }
        if(snapshot.hasData){
          return Authenticated();
        }

        return AuthDependencies(child: LoginScreen());
      },);
  }
}