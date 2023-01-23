import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/category_model.dart';
import 'package:qaf_store/models/favorite_model.dart';
import 'package:qaf_store/models/get_favorites_model.dart';
import 'package:qaf_store/models/home_data.dart';
import 'package:qaf_store/models/user_data.dart';
import 'package:qaf_store/modules/cart_screen/cart_screen.dart';
import 'package:qaf_store/modules/favorite_screen/favorite_screen.dart';
import 'package:qaf_store/modules/home_screen/home_screen.dart';
import 'package:qaf_store/modules/product_screen/products_screen.dart';
import 'package:qaf_store/modules/profile_screen/profile_screen.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';
import 'package:qaf_store/shared/data/network/dio_helper.dart';
import 'package:qaf_store/shared/data/network/end_points.dart';

import '../../components/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit getContext(context) => BlocProvider.of(context);

  int currentIndex = 0;

  HomeModel? dataModel;
  CategoryModel? categoryModel;
  FavoriteModel? favoriteModel;
  FavoritesModel? favoritesModel;
  UserLoginData? userLoginData;

  Map<int, bool> favorites = {};

  List<Widget> screens = [
    HomeScreen(),
    ProductsScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Store Home',
    'Store Products',
    'Store Cart',
    'Store Favorite',
    'Personal Profile'
  ];

  // token = CacheHelper.getData(key: 'token');

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(HomeBottomNavigationState());
  } //end changeBottomNav()

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      dataModel = HomeModel.fromJson(value.data);
      // print(dataModel!.data.products[0].name.toString());
      // print(dataModel!.status);
      dataModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(favorites.toString());
      emit(HomeGetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetDataError());
    });
  } //end getHomeData()

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategoriesGetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesGetDataError());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(FavoritesGetData());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      // print(value.data);

      if (!favoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else
        getFavoritesData();
      emit(FavoritesGetDataSuccess(favoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(FavoritesGetDataError());
    });
  }

  void getFavoritesData() {
    emit(GetFavoritesDataLoading());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // print(value.data);
      emit(GetFavoritesDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesDataError());
    });
  } //end getFavoritesData()

  void getProfileData() {
    emit(GetProfileDataLoading());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userLoginData = UserLoginData.fromJson(value.data);
      print(userLoginData!.data!.name);
      emit(GetProfileDataSuccess());
    }).catchError((error) {
      print('the error is $error');
      emit(GetProfileDataError());
    });
  } //end getProfileData()

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateUserDataLoading());
    DioHelper.updateData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      userLoginData = UserLoginData.fromJson(value.data);
      emit(UpdateUserDataSuccess(userLoginData!));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataError());
    });
  }
} //end class
