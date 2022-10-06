import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applications/models/user_login.dart';
import 'package:flutter_applications/shared/network/end_points.dart';
import 'package:flutter_applications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  UserLogin loginModel;

  void userRegister({
    @required name,
    @required email,
    @required password,
    @required phone,
  }){
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: registerUrl,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value){

      loginModel = UserLogin.fromJson(value.data);

      emit(RegisterSuccessState(loginModel));

    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  var sufIcon = Icon(Icons.visibility_off);
  bool isVisible = true;

  void changePasswordVisibility(){
    isVisible = !isVisible;
    sufIcon = isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ;
    emit(ChangeRegisterVisibilityState());
  }
}