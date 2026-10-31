

enum Signupstatus{initial,loading,loaded,error}

 class SignupState {
final Signupstatus signUpstatus;
  final String? errormessage;

const  SignupState({this.signUpstatus=Signupstatus.initial, this.errormessage});


  SignupState copyWith({
  Signupstatus? status, String? errormessage,bool clearError=false
  }){
    return SignupState(
      signUpstatus: status??signUpstatus,
      errormessage: clearError?null:errormessage);
  }
}



