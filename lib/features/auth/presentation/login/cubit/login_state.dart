enum LoginStatus { initial, loading, loaded, errormessage }

class LoginState {
  final LoginStatus loginstatus;
  final String? errorMessage;

  const LoginState({this.loginstatus = LoginStatus.initial, this.errorMessage});

  LoginState copyWith({LoginStatus? status, String? errormessage,bool clearError=false}) {
    return LoginState(
      errorMessage:
      clearError?null:
       errormessage ?? errorMessage,
      loginstatus: status ?? loginstatus,

    
    );
  }
}
