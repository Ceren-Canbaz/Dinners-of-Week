import 'package:dinners_of_week/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/presentation/style/decoration.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final userRepositroy = UserRepositroy();
  @override
  void initState() {
    getAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: bgprimary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.dinner_dining_outlined,
                size: 120,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Dinners of Week!",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black),
              ),
              TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs
                        .remove('dowUsername'); // 'username' anahtarını siler
                    setState(() {
                      getAuth();
                    });
                  },
                  child: Text("Sil bunu"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final emailExists = prefs.containsKey("dowUsername");
    if (emailExists) {
      final username = prefs.getString('dowUsername');
      if (username != null) {
        final auth =
            await userRepositroy.getUser(username); //send auth as argument
        await Future.delayed(Duration(milliseconds: 750));
        // // Navigator.of(context).pushReplacementNamed("/teams");
      }
    } else {
      await Future.delayed(Duration(milliseconds: 750));
      Navigator.of(context).pushNamed('/signIn');
    }
  }
}
