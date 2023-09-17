import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dinners_of_week/presentation/add_food_page.dart';
import 'package:dinners_of_week/presentation/sign_in_page.dart';
import 'package:dinners_of_week/presentation/sign_up_page.dart';
import 'package:dinners_of_week/repository/food_repository.dart';
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
      title: 'Digitastic Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => FoodRepository(),
        child: TeamsPage(),
      ),
      routes: {
        // Burada "signup" adında bir route tanımlıyoruz
        'signup': (context) => SignUpPage(),
      },
    );
  }
}
