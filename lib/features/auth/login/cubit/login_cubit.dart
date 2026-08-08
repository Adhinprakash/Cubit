import 'package:bloc/bloc.dart';
import 'package:cubit/features/auth/data/auth_repository.dart';
import 'package:cubit/features/auth/login/cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginState>{
  AuthRepository authRepository=AuthRepository();
  LoginCubit({required this.authRepository}):super(LoginState());



  Future<void>login(String email,String password)async{
  try{
emit(state.copyWith(status: LoginStatus.loading));
await authRepository.login(email: email, password: password);
emit(state.copyWith(status: LoginStatus.loaded));
  } on FirebaseAuthException catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }catch(e){
    emit(state.copyWith(status: LoginStatus.errormessage,errormessage: e.toString()));
  }
    
  }
}