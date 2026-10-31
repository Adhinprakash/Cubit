import 'package:cubit/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {

  Future<AuthUser>login({
    required String email,
    required String password
  });

   Future<AuthUser>signUp({
    required String email,
    required String password
  });

  Future<AuthUser> googleLogin();

  Future<void> logout();

  Future<void> resetPassword(String email);

  Future<void> saveUserProfile({
    required AuthUser user,
    required String username,
  });

  
}