import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<List<String>> {
  FavoritesCubit() : super([]) {
    loadFavorites();
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedFavorites = prefs.getStringList('favorites') ?? [];
    emit(savedFavorites);
  }

  void toggleFavorite(String recipe) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> updatedFavorites = List.from(state);

    if (updatedFavorites.contains(recipe)) {
      updatedFavorites.remove(recipe);
    } else {
      updatedFavorites.add(recipe);
    }

    await prefs.setStringList('favorites', updatedFavorites);
    emit(updatedFavorites);
  }
}
