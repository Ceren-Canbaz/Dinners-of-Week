import 'package:dinners_of_week/team/domain/teams_repository.dart';
import 'package:dinners_of_week/team/presentation/detail/cubit/team_detail_cubit.dart';
import 'package:dinners_of_week/team/presentation/team/team_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      ///TODO:fix this dependencies with injectable
      create: (context) => TeamDetailCubit(
        repo: TeamsRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(params.team.name),
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.remove('dowUsername');
                  setState(() {});
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: ListView(children: [
          Text(
            "test ${params.user.isAdmin}",
          ),
          BlocBuilder<TeamDetailCubit, TeamDetailState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  await context.read<TeamDetailCubit>().getWeeklyFoodList(
                        teamId: params.team.id,
                      );
                },
                child: Text("add"),
              );
            },
          )
        ]),
      ),
    );
  }
}
