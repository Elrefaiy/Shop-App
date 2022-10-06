import 'package:flutter_applications/models/user_login.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final UserLogin loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class ChangeVisibilityState extends LoginStates{}



