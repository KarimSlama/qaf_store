import 'package:qaf_store/models/user_data.dart';

abstract class StoreLoginStates {}

class StoreLoginStateInitial extends StoreLoginStates {}

class StoreLoginStateLoading extends StoreLoginStates {}

class StoreLoginStateSuccess extends StoreLoginStates {
  final UserLoginData loginData;

  StoreLoginStateSuccess(this.loginData);
}

class StoreLoginStateError extends StoreLoginStates {
  final String error;

  StoreLoginStateError(this.error);
}

class StoreLoginChangePasswordVisibilityState extends StoreLoginStates {}
