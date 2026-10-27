import 'package:bloc/bloc.dart';
import 'package:cubit/features/auth/repository/auth_firebase_repository.dart';
import 'package:cubit/features/auth/login/cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginState>{
  FirebaseAuthRepository authRepository=FirebaseAuthRepository();
  LoginCubit({required this.authRepository}):super(LoginState());



  Future<void>login(String email,String password)async{
  try{
emit(state.copyWith(status: LoginStatus.loading));
  UserCredential userCredential=await authRepository.login(email: email, password: password);
await authRepository.addTofirebase(userCredential.user!.uid,email);
emit(state.copyWith(status: LoginStatus.loaded));
  } on FirebaseAuthException catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }
    
  }


Future<void>resetPassword(String email)async{
  try {
    emit(state.copyWith(status: LoginStatus.loading));
    await authRepository.resetPassword(email);
    emit(state.copyWith(status: LoginStatus.loaded));
  } on FirebaseAuthException catch (e){
    emit(state.copyWith(errormessage: e.message??'Unable to send reset mail',status:LoginStatus.errormessage));
  }catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: 'Something went wrong. Please try again'));
    
  }
}

Future<void>loginWithGoogle()async{
    try{
emit(state.copyWith(status: LoginStatus.loading));
  UserCredential userCredential=await authRepository.googleLogin();
await authRepository.addTofirebase(userCredential.user?.uid??"",userCredential.user?.email??'');
emit(state.copyWith(status: LoginStatus.loaded));
  } on FirebaseAuthException catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }
    
}

  Future<void>logout()async{

   await FirebaseAuth.instance.signOut();

  }
}