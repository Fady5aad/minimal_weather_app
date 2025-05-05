import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('b146765f353087437e7949825cedb71a');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();
    //fetch weather data
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      //handle error
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  //initState
  @override
  void initState() {
    super.initState();
    //fetch weather data
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      drawer: Drawer(
        child: Consumer<AppState>(
          builder: (context, appState, _) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: appState.isDarkMode,
                  onChanged: (_) => appState.toggleTheme(),
                  secondary: const Icon(Icons.dark_mode),
                ),
                SwitchListTile(
                  title: const Text('Use Fahrenheit'),
                  value: appState.isFahrenheit,
                  onChanged: (_) => appState.toggleUnit(),
                  secondary: const Icon(Icons.thermostat),
                ),
              ],
            );
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // City name at the top
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.grey, // You can customize the color
                  ),
                  Text(
                    _weather?.cityName ?? 'Loading city..',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const Spacer(), // Push animation to vertical center
            // Center animation
            Center(
              child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            ),

            const Spacer(), // Push temp + desc to bottom
            // Temperature
            Consumer<AppState>(
              builder: (context, appState, _) {
                final temp = _weather?.temperature ?? 0;
                final displayedTemp =
                    appState.isFahrenheit
                        ? (temp * 9 / 5 + 32).round()
                        : temp.round();
                final unit = appState.unitLabel;

                return Text(
                  '$displayedTemp$unit',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            // Description
            Text(
              _weather?.mainCondition ?? 'Loading description..',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 60), // Extra bottom spacing
          ],
        ),
      ),
    );
  }
}
