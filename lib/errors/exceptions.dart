class CityNotFoundException implements Exception {}

class NetworkException implements Exception {}

class TimeoutException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationServiceDisabled implements Exception {}

class WeatherApiException implements Exception {
  final int statusCode;
  WeatherApiException(this.statusCode);
}
