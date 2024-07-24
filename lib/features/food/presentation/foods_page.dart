import 'package:dinners_of_week/features/food/domain/food_repository.dart';
import 'package:dinners_of_week/features/food/presentation/cubit/foods_cubit.dart';
import 'package:dinners_of_week/features/food/presentation/widgets/food_card.dart';

import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodsPage extends StatelessWidget {
  const FoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodsCubit(
        repo: FoodRepository(),
      )..getFoods(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Foods"),
        ),
        body: BlocBuilder<FoodsCubit, FoodsState>(builder: (context, state) {
          switch (state.requestState) {
            case RequestState.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case RequestState.loaded:
              return ListView(
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...state.foods.map(
                    (e) => InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.pop(
                            context,
                            e,
                          );
                        },
                        child: FoodCard(
                            name: e.name,
                            description: e.description,
                            hasDrink: e.hasDrink,
                            imageUrl: e.imageUrl)),
                  )

                  ///TODO: Add "Add Food"  option.
                ],
              );

            case RequestState.error:
              return const Expanded(
                child: Center(child: Text("Something Went Wrong")),
              );
          }
        }),
      ),
    );
  }
}
