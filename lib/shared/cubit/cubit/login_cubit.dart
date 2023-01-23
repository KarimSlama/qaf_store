import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/models/user_data.dart';
import 'package:qaf_store/shared/cubit/states/login_states.dart';
import 'package:qaf_store/shared/data/network/dio_helper.dart';
import 'package:qaf_store/shared/data/network/end_points.dart';

class StoreLoginCubit extends Cubit<StoreLoginStates> {
  StoreLoginCubit() : super(StoreLoginStateInitial());

  static StoreLoginCubit getContext(context) => BlocProvider.of(context);

  late UserLoginData loginData;

  userLogin({
    required String email,
    required String password,
  }) {
    emit(StoreLoginStateLoading());
    DioHelper.postData(
      // lang: 'en',
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginData = UserLoginData.fromJson(value.data);
      emit(StoreLoginStateSuccess(loginData));
    }).catchError((error) {
      print('error is in store cubit $error');
      emit(StoreLoginStateError(onError.toString()));
    });
  } //end userLogin()

  userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(StoreLoginStateLoading());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginData = UserLoginData.fromJson(value.data);
      emit(StoreLoginStateSuccess(loginData));
    }).catchError((error) {
      print(error.toString());
      emit(StoreLoginStateError(error));
    });
  } //end userRegister()

  bool isPassword = true;
  IconData suffix = Icons.remove_red_eye_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(StoreLoginChangePasswordVisibilityState());
  } // end changePasswordVisibility()

} //end class
