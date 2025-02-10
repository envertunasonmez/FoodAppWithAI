import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_app_with_ai/cubit/favorites_cubit.dart';
import 'package:food_app_with_ai/cubit/recipe_cubit.dart';
import 'package:food_app_with_ai/cubit/recipe_state.dart';
import 'package:food_app_with_ai/view/favorite_screen.dart';
import 'package:food_app_with_ai/cubit/ingredients_cubit.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _ingredientsController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yemek Tarifleri"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: "Malzemeyi gir",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context
                    .read<IngredientsCubit>()
                    .addIngredient(_ingredientsController.text);
                _ingredientsController.clear();
              },
              child: Text("Malzemeyi Ekle"),
            ),
            SizedBox(height: 20),
            BlocBuilder<IngredientsCubit, List<String>>(
              builder: (context, ingredients) {
                return Wrap(
                  spacing: 8.0,
                  children: ingredients
                      .map((ingredient) => Chip(label: Text(ingredient)))
                      .toList(),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String ingredients =
                    context.read<IngredientsCubit>().state.join(", ");
                context.read<RecipeCubit>().fetchRecipe(ingredients);
              },
              child: Text("Tarifleri Getir"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<IngredientsCubit>().emit([]); // Reset ingredients
                context.read<RecipeCubit>().resetRecipes(); // Reset recipes
              },
              child: Text("Sıfırla"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<RecipeCubit, RecipeState>(
                builder: (context, state) {
                  if (state is RecipeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RecipeLoaded) {
                    return ListView.builder(
                      itemCount: state.recipe.split("\n\n").length,
                      itemBuilder: (context, index) {
                        String recipeItem = state.recipe.split("\n\n")[index];
                        bool isFavorite = context
                            .watch<FavoritesCubit>()
                            .state
                            .contains(recipeItem);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.fastfood, color: Colors.orange),
                            title: Text(recipeItem,
                                style: TextStyle(fontSize: 16)),
                            trailing: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                context
                                    .read<FavoritesCubit>()
                                    .toggleFavorite(recipeItem);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is RecipeError) {
                    return Center(
                      child: Text(state.message,
                          style: TextStyle(color: Colors.red, fontSize: 18)),
                    );
                  }
                  return Center(
                      child: Text("Tarif almak için malzemeleri giriniz."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
