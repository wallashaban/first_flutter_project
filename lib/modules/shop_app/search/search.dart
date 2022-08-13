// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class ShopSearch extends StatelessWidget {
   ShopSearch({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          children: [
            defaultFormFeild(
                controller: searchController,
                text: 'Search',
                prefixIcon: Icons.search,
                type: TextInputType.text,
                ),
          ],
        ),
      ),
    );
  }
}
