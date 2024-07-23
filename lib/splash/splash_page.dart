import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/team/domain/teams_repository.dart';
import 'package:dinners_of_week/auth/domain/user_repositroy.dart';
import 'package:dinners_of_week/auth/domain/services/auth_service.dart';
import 'package:flutter/material.dart';

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
  final AuthService _authService = AuthService();

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
    _authService.authenticateUser(context);
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
}
