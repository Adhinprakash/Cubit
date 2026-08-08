import 'package:cubit/features/auth/data/auth_repository.dart';
import 'package:cubit/features/auth/signup/cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState>{
  final AuthRepository authRepository;
   SignupCubit({required this.authRepository}):super(SignUpInitial());


Future<void>signUp({required String email,required String password})async{
  try{
    emit(SignUpLoading());
await authRepository.signup(email: email, password: password);
emit(SignUpLoaded());
  }on FirebaseAuthException catch(e){
    emit(SignUpError(e.toString()));
  }
  catch(e){
emit(SignUpError(e.toString()));
  }
}


}