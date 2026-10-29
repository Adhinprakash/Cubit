import 'package:cubit/features/auth/repository/auth_firebase_repository.dart';
import 'package:cubit/features/auth/signup/cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState>{
  final FirebaseAuthRepository authRepository;
   SignupCubit({required this.authRepository}):super(SignUpInitial());


Future<void>signUp({required String email,required String password,String? username})async{
  try{
    emit(SignUpLoading());
 UserCredential userCredential=await authRepository.signup(email: email, password: password);
await authRepository.addTofirebase(userCredential.user!.uid,email,username??'');emit(SignUpLoaded());
  }on FirebaseAuthException catch(e){
    emit(SignUpError(e.toString()));
  }
  catch(e){
emit(SignUpError(e.toString()));
  }
}


}