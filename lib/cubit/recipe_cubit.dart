import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/gemini_service.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final GeminiService _geminiService;

  RecipeCubit(this._geminiService) : super(RecipeInitial());

  void fetchRecipe(String ingredients) async {
    if (ingredients.isEmpty) {
      emit(RecipeError("Lütfen malzemeleri giriniz."));
      return;
    }

    emit(RecipeLoading());

    try {
      String result = await _geminiService.getRecipe(ingredients);
      emit(RecipeLoaded(result));
    } catch (e) {
      emit(RecipeError("Tarif alınırken bir hata oluştu."));
    }
  }

  void resetRecipes() {
    emit(RecipeInitial());
  }
}
