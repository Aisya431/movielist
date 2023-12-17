import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/models/movie.dart';

class FetchController {
 Future<Movie> fetchData(String query) async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$query') // Replace with your actual API endpoint
        );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final data = jsonDecode(response.body);
      return Movie.fromJson(data);
    } else {
      // If the server returns an error, throw an exception.
      throw Exception('Failed to load data');
    }
 }
}