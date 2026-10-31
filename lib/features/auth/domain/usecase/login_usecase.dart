import 'package:cubit/features/auth/domain/entities/auth_user.dart';
import 'package:cubit/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);



  Future<AuthUser>call({
       required String email,
    required String password,
  }){
      return repository.login(
      email: email,
      password: password,
    );
  }
}