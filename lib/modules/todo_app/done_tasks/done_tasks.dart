import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/todoapp/cubit/cubit.dart';
import 'package:udemy_course/layout/todoapp/cubit/states.dart';
import 'package:udemy_course/shared/components/components.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit, TodoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoAppCubit.get(context);
        return cubit.doneTasks.isNotEmpty?
        ListView.separated(
          itemCount: cubit.doneTasks.length,
          separatorBuilder: (BuildContext context, int index) {
            return myDivider();
          },
          itemBuilder: (BuildContext context, int index) {
            return buildTAskItem(cubit.doneTasks[index],context);
          },
        ):Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.menu,color: Colors.grey,size: 40,),
                  const SizedBox(height: 10,),
                  titleText(text: 'No tasks yet,please add some tasks',size: 20,color: Colors.black45),
                ],
              ),
            );
      },
    );
  }

}

