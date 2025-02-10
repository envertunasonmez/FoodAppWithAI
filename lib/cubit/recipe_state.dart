import 'package:equatable/equatable.dart';

abstract class RecipeState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final String recipe;
  RecipeLoaded(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);

  @override
  List<Object> get props => [message];
}
