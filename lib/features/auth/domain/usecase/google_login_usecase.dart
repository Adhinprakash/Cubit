import 'package:cubit/features/auth/domain/repository/auth_repository.dart';

import '../entities/auth_user.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<AuthUser>call() {
    return repository.googleLogin();
  }
}