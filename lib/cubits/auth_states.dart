abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailureSState extends AuthState {
  String? failureMessage;
  LoginFailureSState({this.failureMessage});
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  String? failureMessage;
  SignUpFailureState({this.failureMessage});
}
