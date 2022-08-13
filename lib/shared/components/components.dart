// ignore_for_file: sized_box_for_whitespace, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_course/layout/todoapp/cubit/cubit.dart';
import 'package:udemy_course/modules/news_app/webview/webview_screen.dart';

defaultFormFeild({
  required var controller,
  bool isPassword = false,
  required var text,
  required IconData prefixIcon,
  required var type,
  IconData? suffixIcon,
  var onChanged,
  var onSubmitted,
  var suffixPressed,
  var validator,
  var onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      obscureText: isPassword,
      onTap: onTap,
      decoration: InputDecoration(
        label: Text(text),
        prefixIcon: Icon(prefixIcon),
        suffixIcon:
            IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)),
        border: const OutlineInputBorder(),
      ),
    );

defualtButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required var text,
  double height = 50,
  required var onPressed,
}) {
  return Container(
    width: width,
    height: height,
    color: color,
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

titleText({
  required var text,
  Color? color,
  double size = 30,
  var fontWeight = FontWeight.bold,
  var overFlow,
  var maxLines,
}) =>
    Text(
      text,
      overflow: overFlow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );

myDivider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[200],
    ));

navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigateAndeFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), ((route) => false));
}

buildTAskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: titleText(
                  text: '${model['date']}', color: Colors.white, size: 16),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  titleText(text: '${model['title']}', size: 25),
                  titleText(
                      text: '${model['time']}', size: 20, color: Colors.grey),
                ],
              ),
            ),
            if (model['status'] == 'New')
              Row(
                children: [
                  // if(model['status']=='done')
                  IconButton(
                    onPressed: () {
                      TodoAppCubit.get(context)
                          .updateDatabase(status: 'done', id: model['id']);
                    },
                    icon: const Icon(Icons.check_box),
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      TodoAppCubit.get(context)
                          .updateDatabase(status: 'archived', id: model['id']);
                    },
                    icon: const Icon(Icons.archive),
                    color: Colors.black45,
                  ),
                ],
              ),
          ],
        ),
      ),
      onDismissed: (direction) {
        TodoAppCubit.get(context).deleteDatabase(id: model['id']);
      },
    );

Widget buildNewsItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
            context: context, widget: WebViewScreen(url: article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget newsItemBuilder(list, context) => ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) {
        return myDivider();
      },
      itemBuilder: (BuildContext context, int index) {
        return buildNewsItem(list[index], context);
      },
    );

void showToast({required String message,required ToastState state}) => Fluttertoast.showToast(
      msg: message,
      backgroundColor: chooseToastColor(state),
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      fontSize: 16,
    );

enum ToastState { SUCCESS, WARNING, ERROR }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.yellow;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

