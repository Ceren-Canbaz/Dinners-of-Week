import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_bloc/team_bloc.dart';
import 'package:dinners_of_week/auth/data/models/auth.dart';
import 'package:dinners_of_week/features/team/data/models/team.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    final auth = ModalRoute.of(context)!.settings.arguments as Auth;

    return BlocProvider(
      create: (context) {
        return TeamBloc(TeamsRepository())..add(TeamInitialEvent());
      },
      child: Scaffold(
        backgroundColor: AppColors.eggshellColor,
        body: WillPopScope(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                Wrap(
                  children: [
                    Text(
                      "Welcome ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: AppColors.ligtBlueColor,
                              fontWeight: FontWeight.w600),
                    ),
                    Text(
                      auth.username,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: AppColors.darkGreen,
                              fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: AppColors.brownSugarColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Join a team!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.brownSugarColor.withOpacity(0.7),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Enter the team code your team shared with you, and don't miss out on anything",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 64.0,
                            ),
                            child: BlocConsumer<TeamBloc, TeamState>(
                              listener: (context, state) {
                                if (state is TeamJoinedState) {
                                  Navigator.of(context).pushReplacementNamed(
                                      "/team_home",
                                      arguments: TeamHomePageParameters(
                                          user: state.user, team: state.team));
                                }
                              },
                              builder: (context, state) {
                                return TextField(
                                  onSubmitted: (value) {
                                    BlocProvider.of<TeamBloc>(context).add(
                                      TeamJoinEvent(
                                          teamCode: value,
                                          user: auth.copyWith(isAdmin: false)),
                                    );
                                  },
                                  cursorColor: Colors.black,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: AppColors.ligtBlueColor,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Create a Team!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.ligtBlueColor.withOpacity(0.7),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "If you want to make edits in the weekly meal planning and share it with your team, what are you waiting for? Quickly create a team and invite your team members!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 64.0,
                              ),
                              child: BlocConsumer<TeamBloc, TeamState>(
                                  listener: (context, state) {
                                if (state is TeamCreatedState) {
                                  Navigator.of(context).pushReplacementNamed(
                                      "/team_home",
                                      arguments: TeamHomePageParameters(
                                          user: state.user, team: state.team));
                                }
                              }, builder: (context, state) {
                                return TextField(
                                    onSubmitted: (value) async {
                                      BlocProvider.of<TeamBloc>(context).add(
                                        TeamCreateEvent(
                                            teamName: value,
                                            user: auth.copyWith(isAdmin: true)),
                                      );
                                    },
                                    cursorColor: Colors.white,
                                    decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ));
                              })),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.remove('dowUsername');
                      setState(() {});
                    },
                    icon: const Icon(Icons.run_circle))
              ],
            ),
          ),
          onWillPop: () async {
            return false;
          },
        ),
      ),
    );
  }
}

class TeamHomePageParameters {
  final Auth user;
  final TeamModel team;

  TeamHomePageParameters({required this.user, required this.team});
}
