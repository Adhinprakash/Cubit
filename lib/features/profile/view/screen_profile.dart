import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/auth/login/cubit/login_cubit.dart';
import 'package:cubit/features/auth/login/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(children: [
      Column(children: [
      IconButton(onPressed: ()async{
        context.read<LoginCubit>().logout();
        Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => LoginScreen()),
  (Route<dynamic> route) => false,
);
      }, icon: Icon(Icons.logout))
            ],)
      ],)
    );
  }
}