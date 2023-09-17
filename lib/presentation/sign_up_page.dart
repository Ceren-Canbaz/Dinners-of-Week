import 'package:dinners_of_week/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(UserRepositroy())..add(SignUpInitialEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Digitastic Food"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                    hintText: "Username ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
              // BlocBuilder<AuthBloc, AuthState>(
              //   builder: (context, state) {
              //     return ElevatedButton(
              //         onPressed: () {}, child: Text("allaalla"));
              //   },
              // )
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          userNameController.text.isNotEmpty) {
                        setState(() {
                          BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                              auth: Auth(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: userNameController.text,
                                  salt: ""))); // Event'i
                        });
                      }
                    },
                    child: const Text(
                      "Sign up",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              Text("test ${passwordController.text}"),
              Text("test ${passwordController.text}"),
              Text("test ${passwordController.text}"),
              Text("test ${passwordController.text}"),
            ],
          ),
        ),

        // body: BlocBuilder<AuthBloc, AuthState>(
        //   builder: (context, state) {
        //     return Container();
        //   },
        // ),
      ),
    );
  }
}
