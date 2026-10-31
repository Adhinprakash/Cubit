import 'dart:math';

import 'package:cubit/features/auth/domain/entities/auth_user.dart';
import 'package:cubit/features/auth/domain/usecase/save_profile_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/signup_usecase.dart';
import 'package:cubit/features/auth/presentation/signup/cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState>{
  final SaveUserProfileUseCase saveUserProfileUseCase;
  final SignupUseCase signupUseCase;
   SignupCubit({required this.saveUserProfileUseCase,required this.signupUseCase}):super(SignupState());


Future<void>signUp({required String email,required String password,String? username})async{
  try{
    emit(state.copyWith(status: Signupstatus.loading,clearError: true));
 AuthUser user = await signupUseCase(email: email,password: password);

await saveUserProfileUseCase(user: user,username: username??'');
    emit(state.copyWith(status: Signupstatus.loaded,clearError: true));

  }on FirebaseAuthException catch(e){
    _emitError(e);
  }
  catch(e){
    _emitError(e);
  }
}

  void _emitError(Object error) {
    emit(state.copyWith(
      status: Signupstatus.error,
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