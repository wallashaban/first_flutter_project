// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/models/shop_model/login_model.dart';
import 'package:udemy_course/modules/shop_app/shop_register/cubit/states.dart';
import 'package:udemy_course/shared/network/remote/dio_helper.dart';
import 'package:udemy_course/shared/network/remote/endpoints.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void changePassState() {
    isPassword = !isPassword;
    emit(ShopRegisterChangePassState());
  }

  ShopLoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,  
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: register, data: {
      'email': email,
      'password': password,
      'name':name,
      'phone':phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(ShopRegisterSuccessState(shopLoginModel: loginModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error: error));
    });
  }
}
