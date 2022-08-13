// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_layout/cubit/states.dart';
import 'package:udemy_course/models/shop_model/home_model.dart';
import 'package:udemy_course/modules/shop_app/categories/categories.dart';
import 'package:udemy_course/modules/shop_app/favourites/favourites.dart';
import 'package:udemy_course/modules/shop_app/home/home.dart';
import 'package:udemy_course/modules/shop_app/settings/settings.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/network/remote/dio_helper.dart';
import 'package:udemy_course/shared/network/remote/endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNavbar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavbarState());
  }

  List<Widget> screens = [
    const ShopHomeScreen(),
    const ShopCategoriesScreen(),
    const ShopFavouritesScreen(),
    const ShopSettingsScreen(),
  ];

  HomeModel? model;

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: home, token: token).then((value) {
      // print(value.data);
      model = HomeModel.fromJson(value.data);
      print(model!.data!.products[0].name);
      emit(ShopGetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeDataErrorState(error: error.toString()));
    });
  }
}
