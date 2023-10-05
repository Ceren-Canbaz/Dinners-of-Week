import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dinners_of_week/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/presentation/style/decoration.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  String firstResponse = "";

  String secondResponse = "";
  String salt = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthBloc(UserRepositroy())..add(SignInInitialEvent());
      },
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background2.jpeg"),
                    fit: BoxFit.fill)),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: titlecolor,
                                      fontWeight: FontWeight.w400),
                            )),
                      ),
                      TextField(
                          controller: emailController,
                          decoration:
                              textFieldDecoration(hintText: "Username")),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              textFieldDecoration(hintText: "Password")),
                      const SizedBox(
                        height: 12,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          //navigate to teams page
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                secondResponse =
                                    hashPassword(emailController.text, salt);
                                setState(() {});
                              },
                              style:
                                  ElevatedButton.styleFrom(primary: titlecolor),
                              child: const Text(
                                "Sign in",
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(
                        color: Colors.black45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't you have an account yet?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: titlecolor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: titlecolor,
                                      fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (i) => random.nextInt(255));

    salt = base64UrlEncode(saltBytes);
    setState(() {});
    return salt;
  }

  String hashPassword(String password, String salt) {
    final codec = Utf8Codec();
    final passwordBytes = codec.encode(password);
    final saltBytes = base64Url.decode(salt); // Buradaki decode'i kaldırın.

    final response = sha256.convert([...saltBytes, ...passwordBytes]);
    setState(() {});
    print("first response =$response");
    return response.toString();
  }

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        firstResponse,
        secondResponse,
        salt
      ];
}
