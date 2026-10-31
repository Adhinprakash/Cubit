import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit/features/auth/data/datasource/firebase_ath_data_source.dart';
import 'package:cubit/features/auth/data/datasource/firestore_user_data_source.dart';
import 'package:cubit/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:cubit/features/auth/domain/repository/auth_repository.dart';
import 'package:cubit/features/auth/domain/usecase/google_login_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/login_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/logout_usecase.dart';
import 'package:cubit/features/auth/domain/usecase/resetpassword_repositroy.dart';
import 'package:cubit/features/auth/domain/usecase/save_profile_usecase.dart';
import 'package:cubit/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthDependencies extends StatelessWidget {
    final Widget child;

  const AuthDependencies({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAthDataSource>(
          create: (_) => FirebaseAthDataSource(
            FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<FirestoreUserDataSource>(
          create: (_) => FirestoreUserDataSource(
            FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => FirebaseAuthRepositories(
            authDataSource:
                context.read<FirebaseAthDataSource>(),
            userDataSource:
                context.read<FirestoreUserDataSource>(),
          ),
        ),
        RepositoryProvider<LoginUsecase>(
          create: (context) => LoginUsecase(
            context.read<AuthRepository>(),
          ),
        ),
        RepositoryProvider<GoogleLoginUseCase>(
          create: (context) => GoogleLoginUseCase(
            context.read<AuthRepository>(),
          ),
        ),
        RepositoryProvider<LogoutUseCase>(
          create: (context) => LogoutUseCase(
            context.read<AuthRepository>(),
          ),
        ),
        RepositoryProvider<ResetPasswordUseCase>(
          create: (context) => ResetPasswordUseCase(
            context.read<AuthRepository>(),
          ),
        ),
        RepositoryProvider<SaveUserProfileUseCase>(
          create: (context) => SaveUserProfileUseCase(
            context.read<AuthRepository>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) => BlocProvider(
          create: (_) => LoginCubit(
            loginUsecase: context.read<LoginUsecase>(),
            googleLoginUseCase:
                context.read<GoogleLoginUseCase>(),
            logoutUseCase: context.read<LogoutUseCase>(),
            resetPasswordUseCase:
                context.read<ResetPasswordUseCase>(),
            saveUserProfileUseCase:
                context.read<SaveUserProfileUseCase>(),
          ),
          child: child,
        ),
      ),
    );
  }
}