class WeatherAnimationUtils {
  static String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition) {
      case 'Thunderstorm':
        return 'assets/lottie/thunderstorm.json';
      case 'Drizzle':
        return 'assets/lottie/Rain_Sun.json';
      case 'Rain':
        return 'assets/lottie/Rain_Sun.json';
      case 'Snow':
        return 'assets/lottie/blizzard.json';
      case 'Mist':
        return 'assets/lottie/mist.json';
      case 'Clear':
        return 'assets/lottie/sunny.json';
      case 'Clouds':
        return 'assets/lottie/cloud.json';
      default:
        return 'assets/lottie/Loading.json';
    }
  }
}