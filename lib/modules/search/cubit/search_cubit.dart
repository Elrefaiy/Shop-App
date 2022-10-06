import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_applications/models/search.dart';
import 'package:flutter_applications/modules/search/cubit/search_states.dart';
import 'package:flutter_applications/shared/constants/conistants.dart';
import 'package:flutter_applications/shared/network/end_points.dart';
import 'package:flutter_applications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;
  void searchProduct({
    @required String text,
  }){
    emit(SearchLoadingState());

    DioHelper.postData(
        url: searchUrl,
        token: token,
        data: {
          'text' : text,
        },
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error));
    });
  }

}