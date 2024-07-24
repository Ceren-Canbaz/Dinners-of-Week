import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_image_container.dart';
import 'package:dinners_of_week/features/team/presentation/widgets/days_list_widget.dart';
import 'package:dinners_of_week/features/team/presentation/widgets/food_of_day_widget.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_page.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WeeklyPlanPage extends StatefulWidget {
  const WeeklyPlanPage({super.key, required this.params});
  final TeamHomePageParameters params;

  @override
  State<WeeklyPlanPage> createState() => _WeeklyPlanPageState();
}

class _WeeklyPlanPageState extends State<WeeklyPlanPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      ///TODO:fix this dependencies with injectable
      create: (context) =>
          WeeklyPlanCubit(repo: TeamsRepository(), id: widget.params.team.id),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.params.team.name,
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.ligtBlueColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final result = await Navigator.of(context)
                        .pushNamed('/foods') as Food?;
                    if (result != null) {
                      context.read<WeeklyPlanCubit>().addFood(
                            food: result,
                          );
                    }
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
          body: Column(
            children: [
              const DaysListWidget(),
              FoodOfDayWidget(
                isAdmin: widget.params.user.isAdmin ?? false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
