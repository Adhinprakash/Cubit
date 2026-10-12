enum LoginStatus { initial, loading, loaded, errormessage }


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
