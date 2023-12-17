// search_screen.dart
import 'package:flutter/material.dart';
import 'package:travel_app/models/movie.dart';
import 'package:travel_app/post_screen.dart'; // Sesuaikan dengan lokasi model Movie
import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/service/koneksi.dart'; // Sesuaikan dengan lokasi model Movie

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> movies = []; // Daftar film yang akan ditampilkan
  String query = ''; // Kata kunci pencarian
  late HttpService service;

  @override
  void initState() {
    super.initState();
    service = HttpService();
  }

  Future<void> search() async {
    try {
      List<Movie> searchResults = await service.searchMovies(query);
      setState(() {
        movies = searchResults;
      });
    } catch (e) {
      // Handle error
      print('Error searching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase();
                });
              },
              onSubmitted: (value) {
                // Panggil fungsi pencarian saat pengguna menekan tombol "Enter" pada keyboard
                search();
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for movies...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text('Rating: ${movie.voteAverage.toString()}'),
                  onTap: () {
                    // Navigasi ke halaman detail film saat item daftar dipilih
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetail(movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
