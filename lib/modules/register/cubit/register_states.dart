import 'package:flutter_applications/models/user_login.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final UserLogin loginModel;
  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}

class ChangeRegisterVisibilityState extends RegisterStates{}



