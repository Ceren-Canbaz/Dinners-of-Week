import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/features/team/presentation/team/team_page.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:flutter/material.dart';
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
          body: Column(
            children: [
              //fix this with  custom appbar and add preffered size
              const SizedBox(
                height: 18,
              ),
              BlocBuilder<WeeklyPlanCubit, WeeklyPlanState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.weekDays.length,
                          itemBuilder: (context, index) {
                            final date = state.weekDays[index];
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<WeeklyPlanCubit>()
                                    .setCurrentDay(date: date);
                              },
                              child: Container(
                                width:
                                    100.0, // Adjust the width to fit your design
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: state.selectedDate.day == date.day
                                      ? AppColors.darkGreen
                                      : AppColors.beige,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  DateFormat('EEE\ndd').format(date),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: state.selectedDate == date
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
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
                      if (state.foods.isNotEmpty) {
                        return const Center(
                          child: Text("yuklendi agam"),
                        );
                      } else {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Todays plan not ready yet"),
                              if (widget.params.user.isAdmin ?? false)
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/foods');
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
