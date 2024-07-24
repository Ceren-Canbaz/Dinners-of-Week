import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_card.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_image_container.dart';
import 'package:dinners_of_week/features/team/presentation/widgets/days_list_widget.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_page.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
              //fix this with  custom appbar and add preffered size
              const SizedBox(
                height: 18,
              ),
              const DaysListWidget(),
              BlocBuilder<WeeklyPlanCubit, WeeklyPlanState>(
                builder: (context, state) {
                  switch (state.requestState) {
                    case RequestState.initial:
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    case RequestState.loading:
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    case RequestState.loaded:
                      if (state.selectedDaysFood != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 42),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageContainer(
                                  imageUrl: state.selectedDaysFood!.imageUrl),
                              const SizedBox(
                                height: 12,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                shadowColor: Colors.black.withOpacity(0.5),
                                color: AppColors.eggshellColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.selectedDaysFood!.foodName,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.brownSugarColor,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 8,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        state.selectedDaysFood!.foodDescription,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.darkGreen
                                              .withOpacity(0.8),
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 8,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Todays plan not ready yet"),
                              if (widget.params.user.isAdmin ?? false)
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.of(context)
                                        .pushNamed('/foods') as Food?;
                                    if (result != null) {
                                      context.read<WeeklyPlanCubit>().addFood(
                                            food: result,
                                          );
                                    }
                                  },
                                  child: const Text("Add"),
                                )
                            ],
                          ),
                        );
                      }

                    case RequestState.error:
                      return const Center(
                        child: Text("Something Went Wrong "),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
