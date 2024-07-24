import 'dart:math';

import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/auth/data/models/team_user.dart';
import 'package:dinners_of_week/features/team/data/models/team.dart';
import 'package:dinners_of_week/features/team/data/models/team_food_detail.dart';

///TODO: Move this methods to data layer and add dartz to repository
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

  Future<void> setCodeToUser(
      {required TeamUser user, required String code}) async {
    try {
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
      {required String teamCode, required TeamUser user}) async {
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

  Future<void> addFoodToCalendar({
    required String teamId,
    required String foodId,
    required DateTime date,
  }) async {
    try {
      await supabase.from("weekly_food").insert(
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

  Future<void> editCalendar({
    required String id,
    required String foodId,
  }) async {
    try {
      await supabase.from("weekly_food").update(
        {
          'foodId': foodId,
        },
      ).eq(
        "id",
        id,
      );
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<TeamFoodDetails>> getWeeklyFoodList(
      {required String teamId}) async {
    try {
      final response = await supabase
          .from('weekly_food_detail')
          .select('*')
          .eq('teamId', teamId) as List;

      final foods =
          response.map((item) => TeamFoodDetails.fromMap(item)).toList();
      return foods;
    } catch (e) {
      rethrow;
    }
  }
}

Future<String> createCode(String name) async {
  final random = Random();
  const letters = '1234#?!';
  final code = name.substring(0, 4).toUpperCase() +
      String.fromCharCodes(
        Iterable.generate(
          2,
          (_) => letters.codeUnitAt(
            random.nextInt(
              letters.length,
            ),
          ),
        ),
      );
  final response =
      await supabase.from("teams").select().eq('code', code).execute();
  if (response.data.isEmpty) {
    return code;
  } else {
    return await createCode(name);
  }
}
