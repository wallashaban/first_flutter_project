// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/models/shop_model/login_model.dart';
import 'package:udemy_course/modules/shop_app/shop_login/cubit/states.dart';
import 'package:udemy_course/shared/network/remote/dio_helper.dart';
import 'package:udemy_course/shared/network/remote/endpoints.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePassState() {
    isPassword = !isPassword;
    emit(ShopLoginChangePassState());
  }

  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print('/////////////////////////////');
      print(value.data['data']['token']);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.data!.token);
      emit(ShopLoginSuccessState(shopLoginModel: loginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error: error));
    });
  }
}
