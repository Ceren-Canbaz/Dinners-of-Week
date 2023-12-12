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

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final userRepositroy = UserRepositroy();
  final teamRepository = TeamsRepository();
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 280, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {
          ;
        });
      });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
    getAuth();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: eggshellColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SizedBox(
                height: _animation.value,
                child: Image.asset("assets/splash-logo-orange.png")),
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
