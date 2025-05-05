// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/weather_page.dart';
import 'state/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Comic_Relief',
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 32),
          bodyMedium: TextStyle(fontSize: 38),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Comic_Relief',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          titleMedium: TextStyle(fontSize: 32, color: Colors.grey),
          bodyMedium: TextStyle(fontSize: 38, color: Colors.grey),
        ),
      ),
      themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const WeatherPage(),
    );
  }
}
