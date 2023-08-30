import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dinners_of_week/presentation/add_food_page.dart';
import 'package:dinners_of_week/presentation/teams_page.dart';
import 'package:dinners_of_week/repository/food_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://mtgojpizbovzygqfgsdh.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10Z29qcGl6Ym92enlncWZnc2RoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI0NzA3OTMsImV4cCI6MjAwODA0Njc5M30.M9buwHmxyH0_2TbZef6ijVAIwFBOi87wIoqcZp3UaYc",
      authFlowType: AuthFlowType.pkce);
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  }
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        ));
  }
}
