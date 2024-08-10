// model/air_pollution_data.dart
class AirPollutionData {
  final String city;
  final int aqi;

  AirPollutionData({required this.city, required this.aqi});

  factory AirPollutionData.fromJson(Map<String, dynamic> json) {
    return AirPollutionData(
      city: json['data']['city']['name'],
      aqi: json['data']['aqi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'aqi': aqi,
    };
  }
}
