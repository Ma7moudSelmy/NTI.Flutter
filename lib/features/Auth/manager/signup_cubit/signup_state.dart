abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {}

class SignupRememberMeState extends SignupState {}

class SignupShowPassState extends SignupState {}
