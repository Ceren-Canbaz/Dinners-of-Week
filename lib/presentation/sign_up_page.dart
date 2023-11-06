import 'package:dinners_of_week/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/presentation/sign_in_page.dart';
import 'package:dinners_of_week/presentation/style/decoration.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController = TextEditingController();
  bool passwordMatch = true;
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthBloc(UserRepositroy())..add(SignUpInitialEvent());
      },
      child: Scaffold(
        backgroundColor: eggshellColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: ligtBlueColor,
                                  fontWeight: FontWeight.w400),
                        )),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return TextField(
                      controller: userNameController,
                      decoration: textFieldDecoration(
                          hintText: "Username", color: ligtBlueColor),
                      onChanged: (value) {
                        if (state is AuthErrorState) {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignUpInitialEvent());
                        }
                        final cleanedValue = value.replaceAll(" ", "");
                        userNameController.text = cleanedValue;
                      },
                    );
                  }),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: textFieldDecoration(
                          hintText: "Password", color: ligtBlueColor)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: password2Controller,
                    onChanged: (value) {
                      if (passwordController.text == password2Controller.text) {
                        passwordMatch = true;
                      } else {
                        passwordMatch = false;
                      }
                      setState(() {});
                    },
                    obscureText: true,
                    decoration: textFieldDecoration(
                        hintText: "Verify Password", color: ligtBlueColor),
                  ),
                  if (!passwordMatch) const Text("Passwords not match"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: BlocConsumer<AuthBloc, AuthState>(
                        builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (state is AuthErrorState) Text(state.error),
                              SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: passwordMatch &&
                                          userNameController.text.isNotEmpty
                                      ? () async {
                                          if (passwordController
                                                  .text.isNotEmpty &&
                                              userNameController
                                                  .text.isNotEmpty) {
                                            setState(
                                              () {
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .add(
                                                  SignUpEvent(
                                                    auth: Auth(
                                                        id: "",
                                                        password:
                                                            passwordController
                                                                .text,
                                                        username:
                                                            userNameController
                                                                .text,
                                                        isAdmin: false,
                                                        salt: "",
                                                        teamCode: ""),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      primary: ligtBlueColor),
                                  child: Text(
                                    "Sign up",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    }, listener: (context, state) {
                      if (state is SignInState) {
                        //navigate to teams page with user (auth)
                        Navigator.of(context).pushReplacementNamed("/teams",
                            arguments: state.auth);
                      }
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You already have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: darkGreen),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signIn');
                        },
                        child: Text(
                          "Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: brownSugarColor,
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
    );
  }
}
