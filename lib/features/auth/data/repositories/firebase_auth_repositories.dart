import 'package:cubit/features/auth/data/datasource/firebase_ath_data_source.dart';
import 'package:cubit/features/auth/data/datasource/firestore_user_data_source.dart';
import 'package:cubit/features/auth/data/models/auth_user_model.dart';
import 'package:cubit/features/auth/domain/entities/auth_user.dart';
import 'package:cubit/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepositories implements AuthRepository{

    final FirebaseAthDataSource authDataSource;
  final  FirestoreUserDataSource userDataSource;

  FirebaseAuthRepositories({required this.authDataSource, required this.userDataSource});



  AuthUserModel _mapmodels(User? user){
    if(user==null){
      throw StateError('Authentication returned no user.') ;
    }

    return AuthUserModel.fromFirebase(user);
  }
  @override
  Future<AuthUser> googleLogin() async{
   final credential = await authDataSource.googleLogin();

    
  return _mapmodels(credential.user);
  }

  @override
  Future<AuthUser> login({required String email, required String password}) async{
       final credential = await authDataSource.login(
      email: email,
      password: password,


    );

    return _mapmodels(credential.user);
  }

  @override
  Future<void> logout() {
       return authDataSource.logout();

  }

  @override
  Future<void> resetPassword(String email) {
    return authDataSource.resetPassword(email);
  }

  @override
  Future<void> saveUserProfile({required AuthUser user, required String username}) async{
   
  }

  @override
  Future<AuthUser> signUp({required String email, required String password})async {
       final credential = await authDataSource.signup(
      email: email,
      password: password,
    );

    return _mapmodels(credential.user);
  }


  
}