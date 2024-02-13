import 'package:flutter/material.dart';

import 'package:app_movies/screens/exports_screens.dart';
import 'package:provider/provider.dart';
import 'package:app_movies/providers/movie_provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //AQUÍ SE AGREGAN LOS PROVIDERS
        ChangeNotifierProvider(create: (_) => MovieProvider())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.teal
        )
      ),
    );
  }
}