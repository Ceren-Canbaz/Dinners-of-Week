import 'package:dinners_of_week/features/food/domain/food_repository.dart';
import 'package:dinners_of_week/features/food/presentation/cubit/foods_cubit.dart';
import 'package:dinners_of_week/style/colors.dart';
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
                    (e) => Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(e.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              e.name, // Replace with e.name
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              e.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
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
