import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/team.dart';

class TeamsRepository {
  Future<void> createTeam(String name) async {
    try {
      final team = TeamModel(id: "", name: name);
      final response =
          await supabase.from("teams").insert(team.toMap()).select();
    } catch (e) {
      throw Exception();
    }
  }
}
