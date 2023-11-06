import 'package:dinners_of_week/presentation/teams_page.dart';
import 'package:flutter/material.dart';

class TeamHomePage extends StatelessWidget {
  const TeamHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final params =
        ModalRoute.of(context)!.settings.arguments as TeamHomePageParameters;
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: Text("aaa"))],
      ),
      body: ListView(children: [Text("test ${params.user.isAdmin}")]),
    );
  }
}
