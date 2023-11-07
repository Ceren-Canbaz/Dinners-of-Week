import 'package:dinners_of_week/presentation/teams_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamHomePage extends StatefulWidget {
  const TeamHomePage({super.key});

  @override
  State<TeamHomePage> createState() => _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage> {
  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as TeamHomePageParameters;
    return Scaffold(
      appBar: AppBar(
        title: Text("Teams"),
        actions: [
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();

                await prefs.remove('dowUsername');
                setState(() {});
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView(children: [
        Text(
          "test ${params.user.isAdmin}",
        )
      ]),
    );
  }
}
