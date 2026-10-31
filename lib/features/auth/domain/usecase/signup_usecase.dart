import 'package:cubit/features/auth/domain/repository/auth_repository.dart';

import '../entities/auth_user.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<AuthUser> call({
    required String email,
    required String password,
  }) {
    return repository.signUp(
      email: email,
      password: password,
    );
  }
}