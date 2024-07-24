import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DaysListWidget extends StatelessWidget {
  const DaysListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyPlanCubit, WeeklyPlanState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.weekDays.length,
                itemBuilder: (context, index) {
                  final date = state.weekDays[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<WeeklyPlanCubit>()
                            .setCurrentDay(date: date);
                      },
                      child: Container(
                        width: 56,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: state.selectedDate.day == date.day
                              ? AppColors.darkGreen.withOpacity(0.3)
                              : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd').format(date),
                              style: TextStyle(
                                color: state.selectedDate == date
                                    ? AppColors.red
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              DateFormat('EEE').format(date),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: state.selectedDate == date
                                    ? AppColors.red.withOpacity(0.8)
                                    : AppColors.grayColor.withOpacity(0.4),
                              ),
                            ),
                          ],
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
    );
  }
}
