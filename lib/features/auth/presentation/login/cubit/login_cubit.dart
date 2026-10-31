import 'package:bloc/bloc.dart';
import 'package:cubit/features/auth/domain/entities/auth_user.dart';
import 'package:cubit/features/auth/domain/usecase/google_login_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/login_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/logout_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/resetpassword_repositroy.dart';
import 'package:cubit/features/auth/domain/usecase/save_profile_usecase.dart';
import 'package:cubit/features/auth/repository/auth_firebase_repository.dart';
import 'package:cubit/features/auth/presentation/login/cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCubit extends Cubit<LoginState>{

  final LoginUsecase loginUsecase;
    final GoogleLoginUseCase googleLoginUseCase;
  final LogoutUseCase logoutUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SaveUserProfileUseCase saveUserProfileUseCase;
  LoginCubit({ required this.loginUsecase, required this.googleLoginUseCase, required this.logoutUseCase, required this.resetPasswordUseCase, required this.saveUserProfileUseCase}):super(LoginState());



  Future<void>login(String email,String password)async{
  try{
emit(state.copyWith(status: LoginStatus.loading,clearError: true));
  await loginUsecase(email:email,password: password );
emit(state.copyWith(status: LoginStatus.loaded,clearError: true));
  } on FirebaseAuthException catch(e){
    _emitError(e);
  }catch(e){
    _emitError(e);
  }
    
  }


Future<void>resetPassword(String email)async{
  try {
    emit(state.copyWith(status: LoginStatus.loading,clearError: true));
    await resetPasswordUseCase(email);
    emit(state.copyWith(status: LoginStatus.loaded,clearError: true));
  } on FirebaseAuthException catch (e){
    _emitError(e);
  }catch(e){
_emitError(e);    
  }
}

Future<void>loginWithGoogle()async{
  emit(state.copyWith(status: LoginStatus.loading,clearError: true));

    try{
 AuthUser user= await googleLoginUseCase();

await saveUserProfileUseCase(user: user,username: user.displayName??'');

emit(state.copyWith(status: LoginStatus.loaded,clearError: true));

  } on FirebaseAuthException catch(e){
_emitError(e);    
  }catch(e){
_emitError(e);    
  }
    
}

  Future<void>logout()async{

      try {
      await logoutUseCase();

      emit(const LoginState());
    } catch (e) {
      _emitError(e);
    }

  }

    void _emitError(Object error) {
    emit(state.copyWith(
      status: LoginStatus.errormessage,
      errormessage: _readableError(error),
    ));
  }

  String _readableError(Object error) {
    final message = error.toString();

    return message.startsWith('Exception: ')
        ? message.substring('Exception: '.length)
        : message;
  }
}

