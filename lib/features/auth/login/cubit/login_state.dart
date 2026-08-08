enum LoginStatus { initial, loading, loaded, errormessage }

// class LoginInitial extends LoginState{
//   LoginInitial();
// }
// class LoginLoading extends LoginState{
//   LoginLoading();
// }
// class LoginLoaded extends LoginState{
//   LoginLoaded();
// }
// class LoginError extends LoginState{
//   final String error;
//   LoginError({required this.error});
// }
class LoginState {
  final LoginStatus loginstatus;
  final String? errorMessage;

  const LoginState({this.loginstatus = LoginStatus.initial, this.errorMessage});

  LoginState copyWith({LoginStatus? status, String? errormessage}) {
    return LoginState(
      errorMessage: errormessage ?? errorMessage,
      loginstatus: status ?? loginstatus,
    );
  }
}
