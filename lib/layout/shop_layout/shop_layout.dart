import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_layout/cubit/cubit.dart';
import 'package:udemy_course/layout/shop_layout/cubit/states.dart';
import 'package:udemy_course/modules/shop_app/search/search.dart';
import 'package:udemy_course/modules/shop_app/shop_login/shop_login.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: titleText(text: 'Salla'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context: context, widget: ShopSearch());
                  },
                  icon: const Icon(Icons.search)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavbar(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_sharp), label: 'Favourites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }

  void signOut(context) {
    CasheHelper.clearData(key: 'token').then((value) {
      navigateAndeFinish(context: context, widget: ShopLoginScreen());
    });
  }
}
