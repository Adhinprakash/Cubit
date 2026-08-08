abstract class SignupState {
const SignupState();
}

class SignUpInitial extends SignupState{
  const SignUpInitial();
}
class SignUpLoading extends SignupState{
  const SignUpLoading();
}

class SignUpLoaded extends SignupState{
  const SignUpLoaded();
}

class SignUpError extends SignupState{
  final String error;
  const SignUpError(this.error);
}

