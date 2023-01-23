import 'package:qaf_store/models/favorite_model.dart';
import 'package:qaf_store/models/user_data.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavigationState extends HomeStates {}

class HomeLoadingDataState extends HomeStates {}

class HomeGetDataSuccess extends HomeStates {}

class HomeGetDataError extends HomeStates {}

class CategoriesGetDataSuccess extends HomeStates {}

class CategoriesGetDataError extends HomeStates {}

class FavoritesGetData extends HomeStates {}

class FavoritesGetDataSuccess extends HomeStates {
  final FavoriteModel favoriteModel;

  FavoritesGetDataSuccess(this.favoriteModel);
}

class FavoritesGetDataError extends HomeStates {}

class GetFavoritesDataLoading extends HomeStates {}

class GetFavoritesDataSuccess extends HomeStates {}

class GetFavoritesDataError extends HomeStates {}

class GetProfileDataLoading extends HomeStates {}

class GetProfileDataSuccess extends HomeStates {}

class GetProfileDataError extends HomeStates {}

class UpdateUserDataSuccess extends HomeStates {
  final UserLoginData loginData;

  UpdateUserDataSuccess(this.loginData);
}

class UpdateUserDataError extends HomeStates {}

class UpdateUserDataLoading extends HomeStates {}
