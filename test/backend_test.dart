import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('Weather API Test', () {
    test('should fetch weather data from API', () async {
      // Arrange
      const lat = -7.657042019839018;
      const lon = 109.08006904001746;
      const apiKey = 'ea60ee09f988105664e7d8df01e4cde7';
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey');

      // Act
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      // Assert
      expect(response.statusCode, 200);
      expect(data, isNotNull);
      expect(data['name'], isNotNull); // Nama kota
      expect(data['weather'], isNotNull); // Data cuaca
      expect(data['main'], isNotNull); // Data suhu, tekanan, dll.
    });

    test('should throw an exception when API call fails', () {
      // Arrange
      const lat = -7.657042019839018;
      const lon = 109.08006904001746;
      const wrongApiKey = 'wrong_api_key';
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$wrongApiKey');

      // Act & Assert
      expect(() async {
        final response = await http.get(url);
        if (response.statusCode != 200) {
          throw Exception('Failed to load data');
        }
      }, throwsException);
    });
  });
}
