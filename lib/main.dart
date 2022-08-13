// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:udemy_course/layout/news_app/cubit/cubit.dart';
import 'package:udemy_course/layout/news_app/cubit/states.dart';
import 'package:udemy_course/layout/shop_layout/cubit/cubit.dart';
import 'package:udemy_course/layout/shop_layout/shop_layout.dart';
import 'package:udemy_course/layout/todoapp/cubit/cubit.dart';
import 'package:udemy_course/modules/shop_app/onboarding/onboarding.dart';
import 'package:udemy_course/modules/shop_app/shop_login/shop_login.dart';
import 'package:udemy_course/shared/bloc_observer.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';
import 'package:udemy_course/shared/network/remote/dio_helper.dart';
import 'package:udemy_course/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool? isDark = CasheHelper.getBoolean(key: 'isDark');
  token = CasheHelper.getData(key: 'token');
  print(token);
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  Widget? startWidget;

  if (onBoarding != null) {
    // ignore: unnecessary_null_comparison
    if (token != null) {
      startWidget = const ShopLayout();
    } else {
      startWidget = ShopLoginScreen();
    }
  } else {
    startWidget = const OnboardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    widget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget;
  const MyApp({
    Key? key,
    required this.isDark,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            // ..getBuiness()
            ..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => TodoAppCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: //NewsCubit.get(context).isDark
                // ? ThemeMode.dark
                //:
                ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }
}
