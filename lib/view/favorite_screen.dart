import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_with_ai/cubit/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favori Tarifler")),
      body: BlocBuilder<FavoritesCubit, List<String>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return Center(child: Text("Henüz favori tarif yok."));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              String recipe = favorites[index];
              return Card(
                child: ListTile(
                  title: Text(recipe),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(recipe);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
