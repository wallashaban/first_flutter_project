import 'package:udemy_course/models/shop_model/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginChangePassState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel shopLoginModel;
  ShopLoginSuccessState({
    required this.shopLoginModel,
  });
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState({
    required this.error,
  });
}
