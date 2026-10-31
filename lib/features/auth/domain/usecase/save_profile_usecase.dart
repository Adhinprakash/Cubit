import 'package:cubit/features/auth/domain/repository/auth_repository.dart';

import '../entities/auth_user.dart';

class SaveUserProfileUseCase {
  final AuthRepository repository;

  SaveUserProfileUseCase(this.repository);

  Future<void> call({
    required AuthUser user,
    required String username,
  }) {
    return repository.saveUserProfile(
      user: user,
      username: username,
    );
  }
}