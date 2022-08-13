// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/news_app/cubit/states.dart';
import 'package:udemy_course/modules/news_app/buisness/buisness_screen.dart';
import 'package:udemy_course/modules/news_app/science/science_screen.dart';
import 'package:udemy_course/modules/news_app/sports/sports_screen.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';
import 'package:udemy_course/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNavbar(int index) {
    currentIndex = index;
    if (index == 1) getScience();
    if (index == 2) getSports();
    emit(NewsChangeBottomNavbarState());
  }

  List<Widget> screens = [
    const BuisnessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];

  List<dynamic> buisness = [];
  void getBuiness() {
    emit(NewsGetBuisnessLoadingState());
    // ignore: unnecessary_null_comparison
    if (buisness.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '62a2fa11cbb24d14bf7b7e134d963cab',
      }).then((value) {
        buisness = value.data['articles'];
        print(buisness[0]['title']);
        // print(value.data);
        emit(NewsGetBuisnessSuccessState());
      }).catchError((error) {
        emit(NewsGetBuisnessErrorState(error: error));
      });
    } else {
      emit(NewsGetBuisnessSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    // ignore: unnecessary_null_comparison
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '62a2fa11cbb24d14bf7b7e134d963cab',
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        // print(value.data);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error: error));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    // ignore: unnecessary_null_comparison
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '62a2fa11cbb24d14bf7b7e134d963cab',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        // print(value.data);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error: error));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  bool isDark = false;

  void changeThemeMode({fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
            emit(NewsChangeAppTheme());

    } else {
      isDark = !isDark;
      CasheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
              emit(NewsChangeAppTheme());

      });
    }
  }

  List<dynamic> search = [];
  void getSearch({
    required String value,
  }) {
    emit(NewsGetSearchLoadingState());
    // ignore: unnecessary_null_comparison
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '62a2fa11cbb24d14bf7b7e134d963cab',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      // print(value.data);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error: error));
    });
  }
}
