import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_app_with_ai/cubit/ingredients_cubit.dart';
import 'package:food_app_with_ai/view/home_screen.dart';
import 'cubit/recipe_cubit.dart';
import 'cubit/favorites_cubit.dart';
import 'services/gemini_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RecipeCubit(GeminiService())),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => IngredientsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
