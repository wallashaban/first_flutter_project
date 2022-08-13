// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_layout/shop_layout.dart';
import 'package:udemy_course/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:udemy_course/modules/shop_app/shop_login/cubit/states.dart';
import 'package:udemy_course/modules/shop_app/shop_register/shop_register.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  IconData icon = Icons.visibility_off;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status!) {
              CasheHelper.setData(
                      key: 'token', value: state.shopLoginModel.data!.token)
                  .then((value) {
                // ignore: prefer_const_constructors
                print(state.shopLoginModel.data!.token);
                navigateAndeFinish(context: context, widget:const ShopLayout());
              });
              /* Fluttertoast.showToast(
                msg: state.shopLoginModel.message!,
                backgroundColor: Colors.green,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                toastLength: Toast.LENGTH_SHORT,
                textColor: Colors.white,
                fontSize: 16,
              ); */
            } else {
              showToast(
                message: state.shopLoginModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login to see our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormFeild(
                          controller: emailController,
                          text: 'Email Address',
                          prefixIcon: Icons.email_sharp,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email address must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormFeild(
                            controller: passwordController,
                            prefixIcon: Icons.lock,
                            type: TextInputType.visiblePassword,
                            text: 'Password',
                            isPassword: cubit.isPassword,
                            suffixIcon: cubit.isPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            suffixPressed: () {
                              cubit.changePassState();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password must not be empty';
                              }
                            },
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defualtButton(
                          text: 'LOGIN',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context: context,
                                    widget: ShopRegisterScreen(),
                                  );
                                },
                                child: const Text(
                                  'Register Now ',
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
