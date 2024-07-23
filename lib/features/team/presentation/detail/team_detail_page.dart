import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/features/team/presentation/detail/cubit/team_detail_cubit.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_page.dart';
import 'package:dinners_of_week/features/team/presentation/widgets/food_card.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:dinners_of_week/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamHomePage extends StatefulWidget {
  const TeamHomePage({super.key, required this.params});
  final TeamHomePageParameters params;

  @override
  State<TeamHomePage> createState() => _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      ///TODO:fix this dependencies with injectable
      create: (context) =>
          TeamDetailCubit(repo: TeamsRepository(), id: widget.params.team.id),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.params.team.name),
            actions: [
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.remove('dowUsername');
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.darkGreen,
                  )),
              IconButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.remove('dowUsername');
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: AppColors.darkGreen,
                  ))
            ],
          ),
          body: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              children: [
                BlocBuilder<TeamDetailCubit, TeamDetailState>(
                  builder: (context, state) {
                    switch (state.requestState) {
                      case RequestState.initial:
                        return Container();

                      case RequestState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      case RequestState.loaded:
                        if (state.foods.isNotEmpty) {
                          return FoodCard(
                            foods: state.foods,
                          );
                        } else {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Weekly Dinner plan not ready yet",
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.darkGreen),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                if (widget.params.user.isAdmin ?? false)
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Create Plan",
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }

                      case RequestState.error:
                        return const Center(
                          child: Text(
                              "Something Went Wrong Please Contact with Support"),
                        );
                    }
                  },
                )
              ]),
        ),
      ),
    );
  }
}
