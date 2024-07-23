import 'dart:math';

import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/auth/data/models/auth.dart';
import 'package:dinners_of_week/team/data/models/team.dart';

class TeamsRepository {
  Future<TeamModel> createTeam(String name) async {
    final code = await createCode(name);

    try {
      final team = TeamModel(id: "", name: name, code: code);
      final List<dynamic> response =
          await supabase.from("teams").insert(team.toMap()).select();
      print("response ${response.first}");
      final result = TeamModel.fromMap(response.first);
      return result;
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> setCodeToUser({required Auth user, required String code}) async {
    try {
      print("is admin ${user.isAdmin}");
      await supabase.from("users").update({
        "teamsCode": code,
        "isAdmin": user.isAdmin,
      }).eq("id", user.id);
    } catch (e) {
      throw Exception();
    }
  }

  Future<TeamModel> getTeam(String teamCode) async {
    try {
      final response =
          await supabase.from('teams').select().eq('code', teamCode);
      final data = response as List<dynamic>;
      final team = TeamModel.fromMap(data.first);
      return team;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TeamModel> joinTeam(
      {required String teamCode, required Auth user}) async {
    try {
      final List<dynamic> response =
          await supabase.from('teams').select().eq('code', teamCode).select();
      if (response.isNotEmpty) {
        final data = response as List<dynamic>;
        final team = TeamModel.fromMap(data.first);
        await supabase.from("users").update(
            {"teamsCode": teamCode, "isAdmin": false}).eq("id", user.id);
        return team;
      } else {
        throw Exception("Incorrect team code");
      }

      //update user
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addFoodTeamCalendar({
    required String teamId,
    required String foodId,
    required DateTime date,
  }) async {
    try {
      await supabase.from("team_food").insert(
        {
          'teamId': teamId,
          'foodId': foodId,
          'date': date.toIso8601String(),
        },
      );
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> getWeeklyFoodList({required String teamId}) async {
    final response = await supabase
        .from('weekly_food_detail')
        .select('*')
        .eq('teamId', teamId);
    print(response);
  }
}

Future<String> createCode(String name) async {
  final random = Random();
  const letters = '1234#?!';
  final code = name.substring(0, 4).toUpperCase() +
      String.fromCharCodes(Iterable.generate(
          2, (_) => letters.codeUnitAt(random.nextInt(letters.length))));
  final response =
      await supabase.from("teams").select().eq('code', code).execute();
  if (response.data.isEmpty) {
    return code;
  } else {
    return await createCode(name);
  }
}
