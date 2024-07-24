import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_image_container.dart';
import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/style/buttons.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodOfDayWidget extends StatelessWidget {
  const FoodOfDayWidget({
    super.key,
    required this.isAdmin,
  });
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyPlanCubit, WeeklyPlanState>(
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
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: Text(
                        "Today's Special",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGrayColor,
                          shadows: [
                            Shadow(
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ImageContainer(imageUrl: state.selectedDaysFood!.imageUrl),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        state.selectedDaysFood!.foodName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brownSugarColor,
                          shadows: [
                            Shadow(
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      state.selectedDaysFood!.foodDescription,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGreen.withOpacity(0.8),
                        shadows: [
                          Shadow(
                            offset: const Offset(1.0, 1.0),
                            blurRadius: 8,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    if (isAdmin)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Edit",
                                )),
                            const SizedBox(
                              width: 12,
                            ),
                            DeleteButton(onDelete: () {}, title: "Delete")
                          ],
                        ),
                      )
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Todays plan not ready yet"),
                    if (isAdmin)
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
    );
  }
}
