import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applications/models/user_login.dart';
import 'package:flutter_applications/shared/network/end_points.dart';
import 'package:flutter_applications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserLogin loginModel;

  void userLogin({@required email, @required password}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: loginUrl,
        data: {
          'email' : email,
          'password' : password,
        },
    ).then((value){
      loginModel = UserLogin.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  var sufIcon = Icon(Icons.visibility_off);
  bool isVisible = true;

  void changePasswordVisibility(){
    isVisible = !isVisible;
    sufIcon = isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ;
    emit(ChangeVisibilityState());
  }
}