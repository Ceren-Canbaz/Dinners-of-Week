import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/auth.dart';

class UserRepositroy {
  Future<void> signUp(Auth auth) async {
    await supabase.from("foods").insert(auth.toJson());
  }
}
