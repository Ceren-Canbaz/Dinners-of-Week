import 'dart:math';

import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/model/team.dart';

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
      final response = await supabase
          .from('teams') // Tablo adını buraya ekleyin
          .select()
          .eq('code', teamCode); // 'email' sütunu ile eşleşen verileri al
      final data = response as List<dynamic>;
      final team = TeamModel.fromMap(data.first);
      return team;
    } catch (e) {
      throw Exception();
    }
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
