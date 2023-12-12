import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/presentation/teams_page.dart';
import 'package:dinners_of_week/repository/teams_repository.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final UserRepositroy _userRepository = UserRepositroy();
  final TeamsRepository _teamRepository = TeamsRepository();

  Future<void> authenticateUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final emailExists = prefs.containsKey("dowUsername");

    if (emailExists) {
      final username = prefs.getString('dowUsername');
      if (username != null) {
        try {
          final auth = await _userRepository.getUser(username);
          if (auth.teamCode == "") {
            Navigator.of(context)
                .pushReplacementNamed("/teams", arguments: auth);
          } else {
            final team = await _teamRepository.getTeam(auth.teamCode!);
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
