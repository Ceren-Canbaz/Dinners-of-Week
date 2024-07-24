import 'package:dinners_of_week/auth/presentation/sign_in_page.dart';
import 'package:dinners_of_week/auth/presentation/sign_up_page.dart';
import 'package:dinners_of_week/features/food/presentation/foods_page.dart';
import 'package:dinners_of_week/splash/splash_page.dart';
import 'package:dinners_of_week/style/colors.dart';

import 'package:dinners_of_week/features/team/presentation/weekly_plan/weekly_plan.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_page.dart';
import 'package:dinners_of_week/auth/data/models/team_user.dart';
import 'package:dinners_of_week/auth/domain/user_repositroy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///dotenv dosyaasina cek su url ve anonkeyi canim.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //load env
  await dotenv.load();
  //initialize supabase
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? "";
  String supabaseKey = dotenv.env["SUPABASE_KEY"] ?? "";
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // // if (Platform.isIOS) {
  // //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  // // } else if (Platform.isAndroid) {
  // //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  // // }
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dinners of Week',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Kenarları yuvarlat
            ),
            padding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 24), // İç boşluk
            textStyle: const TextStyle(
              fontSize: 16, // Yazı boyutu
              fontWeight: FontWeight.bold, // Yazı kalınlığı
            ),
            elevation: 5, // Gölgeler
            shadowColor:
                Colors.black.withOpacity(0.15), // Gölge rengi ve şeffaflık
          ),
        ),
      ),
      home: RepositoryProvider(
        create: (context) => UserRepositroy(),
        child: const SplashPage(),
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/signIn': ((context) => const SignInPage()),
        '/teams': (context) => TeamPage(
              user: ModalRoute.of(context)!.settings.arguments as TeamUser,
            ),
        '/team_home': (context) => WeeklyPlanPage(
              params: ModalRoute.of(context)!.settings.arguments
                  as TeamHomePageParameters,
            ),
        '/foods': (context) => const FoodsPage()
      },
    );
  }
}
