import 'package:flutter_applications/models/change_favorites.dart';
import 'package:flutter_applications/models/home.dart';
import 'package:flutter_applications/models/search.dart';
import 'package:flutter_applications/models/user_login.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeBottomNavState extends ShopStates{}

class HomeLoadingState extends ShopStates{}

class HomeDataSuccessState extends ShopStates{}

class HomeDataErrorState extends ShopStates{
  final String error;
  HomeDataErrorState(this.error);
}

class CategoriesDataSuccessState extends ShopStates{}

class CategoriesDataErrorState extends ShopStates{
  final String error;
  CategoriesDataErrorState(this.error);
}

class FavoritesDataSuccessState extends ShopStates{}

class FavoritesChangeSuccessState extends ShopStates{
  final ChangeFavourites model;

  FavoritesChangeSuccessState(this.model);
}

class FavoritesDataErrorState extends ShopStates{
  final String error;
    FavoritesDataErrorState(this.error);
}

class GetFavoriteDataLoadingState extends ShopStates{}

class GetFavoriteDataSuccessState extends ShopStates{}

class GetFavoriteDataErrorState extends ShopStates{
  final String error;
  GetFavoriteDataErrorState(this.error);
}

class GetProfileDataLoadingState extends ShopStates{}

class GetProfileDataSuccessState extends ShopStates{
  final UserLogin userLogin;
  GetProfileDataSuccessState(this.userLogin);
}

class GetProfileDataErrorState extends ShopStates{
  final String error;
  GetProfileDataErrorState(this.error);
}

class UpdateDataLoadingState extends ShopStates{}

class UpdateDataSuccessState extends ShopStates{
  final UserLogin userLogin;
  UpdateDataSuccessState(this.userLogin);
}

class UpdateDataErrorState extends ShopStates{
  final String error;
  UpdateDataErrorState(this.error);
}

class GetProductDataLoadingState extends ShopStates{}

class GetProductDataSuccessState extends ShopStates{
  final ProductModel model;
  GetProductDataSuccessState(this.model);
}

class GetProductDataErrorState extends ShopStates{
  final String error;
  GetProductDataErrorState(this.error);
}






