


import 'package:cubit/firebase_options.dart';
import 'package:cubit/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen()
    );
  }
}
// BlocProvider(create: (context) => SignupCubit(authRepository: FirebaseAuthRepository()),),
// BlocProvider(create: (context) => LoginCubit(authRepository: FirebaseAuthRepository()),),
// BlocProvider(create:(context)=>ProductsCubit(repository: ProductsRepository())),
// BlocProvider(create:(context)=>FavoriteCubit(favRepository: FavRepository())),
// BlocProvider(create:(context)=>CartCubit(repository: CartRepository())),

