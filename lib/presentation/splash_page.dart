import 'package:dinners_of_week/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/presentation/style/decoration.dart';
import 'package:dinners_of_week/presentation/teams_page.dart';
import 'package:dinners_of_week/repository/teams_repository.dart';
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
  final teamRepository = TeamsRepository();
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
        backgroundColor: eggshellColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onLongPress: () async {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs
                      .remove('dowUsername'); // 'username' anahtarını siler
                  setState(() {
                    getAuth();
                  });
                },
                child: Text(
                  "Dinners",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 64,
                        color: ligtBlueColor,
                        fontFamily: 'Agbalumo',
                      ),
                ),
              ),
              Text(
                "of",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 54,
                      color: ligtBlueColor,
                      fontFamily: 'Agbalumo',
                    ),
              ),
              Text(
                "Week!",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 64,
                      color: ligtBlueColor,
                      fontFamily: 'Agbalumo',
                    ),
              ),
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
        try {
          final auth =
              await userRepositroy.getUser(username); //send auth as argument
          if (auth.teamCode == "") {
            Navigator.of(context)
                .pushReplacementNamed("/teams", arguments: auth);
          } else {
            final team = await teamRepository.getTeam(auth.teamCode!);
            Navigator.of(context).pushReplacementNamed("/team_home",
                arguments: TeamHomePageParameters(user: auth, team: team));
          }
        } catch (e) {
          Navigator.of(context).pushNamed('/signIn');
        }
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 750));
      Navigator.of(context).pushNamed('/signIn');
    }
  }
}
