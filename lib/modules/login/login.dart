// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isPassword = true;
  IconData icon = Icons.visibility_off;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
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
                    isPassword: isPassword,
                    suffixIcon:
                        isPassword ? Icons.visibility_off : Icons.visibility,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defualtButton(
                    text: 'LOGIN',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
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
                          onPressed: () {},
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
  }
}
