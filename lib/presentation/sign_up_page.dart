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
        body: Container(
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
                                    color: titlecolor,
                                    fontWeight: FontWeight.w400),
                          )),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return TextField(
                          controller: userNameController,
                          decoration: textFieldDecoration(hintText: "Username"),
                          onChanged: (value) {
                            if (state is AuthErrorState) {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignUpInitialEvent());
                            }
                            final cleanedValue = value.replaceAll(" ", "");
                            userNameController.text = cleanedValue;
                          },
                        );
                      },
                      listener: (context, state) {
                        if (state is AuthLoadedState) {
                          Navigator.of(context)
                              .pushReplacementNamed("/teamMenu");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                        controller: passwordController,
                        onChanged: (value) {},
                        obscureText: true,
                        decoration: textFieldDecoration(hintText: "Password")),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: password2Controller,
                      onChanged: (value) {
                        if (passwordController.text ==
                            password2Controller.text) {
                          passwordMatch = true;
                        } else {
                          passwordMatch = false;
                        }
                        setState(() {});
                      },
                      obscureText: true,
                      decoration:
                          textFieldDecoration(hintText: "Verify Password"),
                    ),
                    if (!passwordMatch) const Text("Passwords not match"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (state is AuthErrorState)
                                    Text(state.error),
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
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            username:
                                                                userNameController
                                                                    .text,
                                                            salt: ""),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                          primary: titlecolor),
                                      child: Text(
                                        "Sign up",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
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
