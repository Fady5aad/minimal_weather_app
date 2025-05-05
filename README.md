A simple Flutter weather application that fetches real-time weather data based on your current location and displays animated weather icons.

## 🔧 Features

- 🌍 Auto-detects your current city using GPS
- 🌡️ Displays temperature and weather conditions
- 🎞️ Animated weather icons with Lottie
- 🌗 Dark mode toggle
- 🔁 Switch between Celsius and Fahrenheit
- 📱 Responsive UI for mobile devices
- 📥 Works offline after installation (on iOS within Apple's constraints)

## 📦 Dependencies

- [`geolocator`](https://pub.dev/packages/geolocator) – for location
- [`geocoding`](https://pub.dev/packages/geocoding) – to get city name
- [`http`](https://pub.dev/packages/http) – to call OpenWeatherMap API
- [`lottie`](https://pub.dev/packages/lottie) – for weather animations
- [`provider`](https://pub.dev/packages/provider) – for state management
- [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) – for custom app icon
