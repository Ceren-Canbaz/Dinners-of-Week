import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_list/bloc/food_bloc.dart';
import 'package:user_list/main.dart';
import 'package:user_list/model/meal.dart';
import 'package:user_list/repository/food_repository.dart';

class AddFoodPage extends StatelessWidget {
  AddFoodPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodBloc(
        RepositoryProvider.of<FoodRepository>(context),
      )..add(LoadFoodEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Digitastic Food"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(48.0),
          child: BlocBuilder<FoodBloc, FoodState>(
            builder: (context, state) {
              return TextField(
                controller: controller,
                onSubmitted: (value) async {
                  final Food newFood = Food(
                      id: "temp",
                      name: value,
                      hasDrink: false,
                      description: "test for json final");
                  print(newFood.toJson());

                  BlocProvider.of<FoodBloc>(context)
                      .add(AddFoodEvent(newFood)); // Event'i tetikleyin
                  controller.text = "";
                },
                textInputAction: TextInputAction.done,
              );
            },
          ),
        ),
        body: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            if (state is FoodInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FoodLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: state.foodList
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.name),
                                BlocBuilder<FoodBloc, FoodState>(
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        BlocProvider.of<FoodBloc>(context)
                                            .add(DeleteFoodEvent(e));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 32,
                                      ),
                                      color: Colors.red.shade900,
                                    );
                                  },
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              );
            }

            return Center(child: Text("Error state"));
          },
        ),
      ),
    );
  }
}
