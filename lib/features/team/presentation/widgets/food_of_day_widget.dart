import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_image_container.dart';
import 'package:dinners_of_week/features/team/presentation/weekly_plan/cubit/weekly_plan_cubit.dart';
import 'package:dinners_of_week/style/buttons.dart';
import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/style/text_decortaion.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:dinners_of_week/utils/extensions/date_extension.dart';
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
            if (state.selectedDaysFood.id != "") {
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
                        style: titleTextStyle(),
                      ),
                    ),
                    ImageContainer(imageUrl: state.selectedDaysFood.imageUrl),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        state.selectedDaysFood!.foodName,
                        textAlign: TextAlign.start,
                        style: titleTextStyle(
                          fontSize: 18,
                          color: AppColors.brownSugarColor,
                        ),
                      ),
                    ),
                    Text(
                      state.selectedDaysFood.foodDescription,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grayColor,
                        shadows: [textShadow()],
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
                            Button(
                                onPressed: () async {
                                  final result = await Navigator.of(context)
                                      .pushNamed('/foods') as Food?;
                                  if (result != null) {
                                    await context
                                        .read<WeeklyPlanCubit>()
                                        .edit(foodId: result.id);
                                  }
                                },
                                child: Text(
                                  "Edit",
                                  style: buttonTextStyle(),
                                )),
                            const SizedBox(
                              width: 12,
                            ),
                            DeleteButton(
                                onDelete: () async {
                                  await context
                                      .read<WeeklyPlanCubit>()
                                      .delete();
                                },
                                title: "Delete")
                          ],
                        ),
                      )
                  ],
                ),
              );
            } else {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: Image.network(
                          "https://www.chetanbharat.com/Backend/assets/images/no-data.png"),
                    ),
                    const Text(
                      "Todays plan not ready yet",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    if (isAdmin)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        child: Button(
                          onPressed: () async {
                            final result = await Navigator.of(context)
                                .pushNamed('/foods') as Food?;
                            if (result != null) {
                              await context.read<WeeklyPlanCubit>().addFood(
                                    food: result,
                                  );
                            }
                          },
                          child: Text(
                            "Add",
                            style: buttonTextStyle(),
                          ),
                        ),
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
