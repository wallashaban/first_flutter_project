// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/layout/shop_layout/shop_layout.dart';
import 'package:udemy_course/modules/shop_app/shop_register/cubit/cubit.dart';
import 'package:udemy_course/modules/shop_app/shop_register/cubit/states.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/network/local/shared_prefrences.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  IconData icon = Icons.visibility_off;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.shopLoginModel.status!) {
              CasheHelper.setData(
                      key: 'token', value: state.shopLoginModel.data!.token)
                  .then((value) {
                // ignore: prefer_const_constructors
                navigateAndeFinish(context: context, widget: ShopLayout());
              });
              /*  Fluttertoast.showToast(
                msg: state.shopLoginModel.message!,
                backgroundColor: Colors.green,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                toastLength: Toast.LENGTH_SHORT,
                textColor: Colors.white,
                fontSize: 16,
              );
           */
            } else {
              showToast(
                  message: state.shopLoginModel.message!,
                  state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
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
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Register to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormFeild(
                          controller: nameController,
                          text: 'Name',
                          prefixIcon: Icons.person,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormFeild(
                          controller: phoneController,
                          text: 'Phone',
                          prefixIcon: Icons.phone,
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defualtButton(
                          text: 'Register',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
