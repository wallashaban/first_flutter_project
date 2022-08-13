import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/news_app/cubit/cubit.dart';
import 'package:udemy_course/layout/news_app/cubit/states.dart';
import 'package:udemy_course/modules/news_app/search/search_screen.dart';
import 'package:udemy_course/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: titleText(
              text: 'News App',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context: context, widget: SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.changeThemeMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_sharp), label: 'Buisness'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science_sharp), label: 'Science'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports_bar_sharp), label: 'Sports'),
              ]),
        );
      },
    );
  }
}
