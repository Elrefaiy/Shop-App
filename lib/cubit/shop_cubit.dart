import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_applications/cubit/shop_states.dart';
import 'package:flutter_applications/models/categories.dart';
import 'package:flutter_applications/models/change_favorites.dart';
import 'package:flutter_applications/models/favorites.dart';
import 'package:flutter_applications/models/home.dart';
import 'package:flutter_applications/models/user_login.dart';
import 'package:flutter_applications/modules/categories/categories.dart';
import 'package:flutter_applications/modules/favourite/favourite.dart';
import 'package:flutter_applications/modules/products/products.dart';
import 'package:flutter_applications/modules/settings/settings.dart';
import 'package:flutter_applications/shared/constants/conistants.dart';
import 'package:flutter_applications/shared/network/end_points.dart';
import 'package:flutter_applications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =[
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  Map<int, bool> favorite = {};

  void changeIndex(index){
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
  
  HomeModel homeModel;
  void getHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(
        url: homeUrl,
        token: token,
    ).then(
            (value) {
              homeModel = HomeModel.fromJson(value.data);
              homeModel.data.products.forEach((element) {
                favorite.addAll({
                  element.id : element.inFavorites,
                });
              });
              emit(HomeDataSuccessState());
            }).catchError((error){
              print(error.toString());
              emit(HomeDataErrorState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
      url: categoriesUrl,
      token: token,
    ).then(
            (value) {
          categoriesModel = CategoriesModel.fromJson(value.data);
          emit(CategoriesDataSuccessState());
        }).catchError((error){
      print(error.toString());
      emit(CategoriesDataErrorState(error.toString()));
    });
  }

  ChangeFavourites changeFavourites;

  void changeFav(int id){
    DioHelper.postData(
        url: favoritesUrl,
        data: {
          'product_id' : id,
        },
      token: token,
    ).then((value) {

      favorite[id] = !favorite[id];
      emit(FavoritesChangeSuccessState(changeFavourites));

      changeFavourites = ChangeFavourites.fromJson(value.data);
      if(!changeFavourites.status){
        favorite[id] = !favorite[id];
      }else{
        getFavoritesData();
      }
      print(changeFavourites.message);
      emit(FavoritesDataSuccessState());
    }).catchError((error){
      favorite[id] = !favorite[id];
      emit(FavoritesDataErrorState(error));
    });
  }

  FavoritesModel favoritesModel;
  void getFavoritesData(){
    emit(GetFavoriteDataLoadingState());

    DioHelper.getData(
      url: favoritesUrl,
      token: token,
    ).then(
            (value) {
              favoritesModel = FavoritesModel.fromJson(value.data);
          emit(GetFavoriteDataSuccessState());
        }).catchError((error){
      print(error.toString());
      emit(GetFavoriteDataErrorState(error.toString()));
    });
  }

  UserLogin userModel;

  void getUserData(){
    emit(GetProfileDataLoadingState());

    DioHelper.getData(
      url: profileUrl,
      token: token,
    ).then(
            (value) {
          userModel = UserLogin.fromJson(value.data);
          emit(GetProfileDataSuccessState(userModel));
        }).catchError((error){
      print(error.toString());
      emit(GetProfileDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }){
    emit(UpdateDataLoadingState());

    DioHelper.putData(
      url: updateUrl,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then(
            (value) {
          userModel = UserLogin.fromJson(value.data);
          emit(UpdateDataSuccessState(userModel));
        }).catchError((error){
      print(error.toString());
      emit(UpdateDataErrorState(error.toString()));
    });
  }
}

