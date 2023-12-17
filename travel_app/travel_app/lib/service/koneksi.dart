import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:travel_app/models/movie.dart';

class HttpService {
  final String apiKey = '9da44c390e219ffdc840f1bc8c1cd1b8';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';
  
  Future<List<Movie>> getPopularMovies() async {
  final String uri = baseUrl + apiKey;

  try {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(response.body);
      final moviesMap = jsonResponse['results'];
      List<Movie> movies = List<Movie>.from(moviesMap.map((i) => Movie.fromJson(i)));
      return movies;
    } else {
      print("Fail");
      throw Exception("Fail");
    }
  } catch (e) {
    print("Exception: $e");
    throw Exception("Fail");
  }
}
 searchMovies(String query) {}
}