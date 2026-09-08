

import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/Home/repository/products_repository.dart';
import 'package:cubit/features/auth/repository/auth_repository.dart';
import 'package:cubit/features/auth/login/cubit/login_cubit.dart';
import 'package:cubit/features/auth/login/view/login.dart';
import 'package:cubit/features/auth/signup/cubit/signup_cubit.dart';
import 'package:cubit/features/auth/signup/view/sign_up.dart';
import 'package:cubit/firebase_options.dart';
import 'package:cubit/widgets/bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

   
    return MultiBlocProvider(providers: [
BlocProvider(create: (context) => SignupCubit(authRepository: AuthRepository()),),
BlocProvider(create: (context) => LoginCubit(authRepository: AuthRepository()),),
BlocProvider(create:(context)=>ProductsCubit(repository: ProductsRepository()))

    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
              
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: NavigationPages()
    ));
  }
}
