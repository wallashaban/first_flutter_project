// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/models/user/usermodel.dart';



class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);
  List<UserModel> model = [
    UserModel(
      name: 'walaa shaaban',
      phone: '01127108998',
      id: 1,
    ),
    UserModel(
      name: 'Pooh',
      phone: '01153677416',
      id: 2,
    ),
    UserModel(
      name: 'Na3nasha',
      phone: '01156551887',
      id: 3,
    ),
    UserModel(
      name: 'walaa shaaban',
      phone: '01127108998',
      id: 4,
    ),
    UserModel(
      name: 'Pooh',
      phone: '01153677416',
      id: 5,
    ),
    UserModel(
      name: 'Na3nasha',
      phone: '01156551887',
      id: 6,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titleText(text: 'Users', color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: model.length,
          separatorBuilder: (BuildContext context, int index) {
            return myDivider();
          },
          itemBuilder: (BuildContext context, int index) {
            return buildUserItem(model[index]);
          },
        ),
      ),
    );
  }

  Widget buildUserItem(UserModel model) => Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: titleText(text: '${model.id}', color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                titleText(
                  text: model.name,
                  size: 25,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  model.phone,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
}
