import 'package:dinners_of_week/auth/presentation/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/auth/data/models/team_user.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/style/input_decoration.dart';
import 'package:dinners_of_week/auth/domain/user_repositroy.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthBloc(UserRepositroy())..add(SignInInitialEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.eggshellColor,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
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
                                    color: AppColors.darkGreen,
                                    fontWeight: FontWeight.w400),
                          )),
                    ),
                    TextField(
                        controller: emailController,
                        decoration: textFieldDecoration(
                            hintText: "Username", color: AppColors.darkGreen)),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: textFieldDecoration(
                            hintText: "Password", color: AppColors.darkGreen)),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is SignInState) {
                          Navigator.of(context).pushReplacementNamed("/teams",
                              arguments: state.user);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            if (state is AuthErrorState) Text(state.error),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignInEvent(
                                      user: TeamUser(
                                          id: "",
                                          password: passwordController.text,
                                          username: emailController.text,
                                          salt: ""),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign in",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.darkGreen,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't you have an account yet?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: AppColors.ligtBlueColor),
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
                                    color: AppColors.brownSugarColor,
                                    fontWeight: FontWeight.w600),
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
    );
  }
}
