import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientsCubit extends Cubit<List<String>> {
  IngredientsCubit() : super([]);

  void addIngredient(String ingredient) {
    if (ingredient.isNotEmpty) {
      emit(List.from(state)..add(ingredient));
    }
  }
}
