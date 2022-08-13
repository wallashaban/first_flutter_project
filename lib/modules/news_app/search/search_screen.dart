// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/news_app/cubit/cubit.dart';
import 'package:udemy_course/layout/news_app/cubit/states.dart';
import 'package:udemy_course/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormFeild(
                    controller: searchController,
                    text: 'Search',
                    prefixIcon: Icons.search,
                    type: TextInputType.text,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value: value);
                    }),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: newsItemBuilder(list,context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
