import 'package:travel_app/post_screen.dart';
import 'package:travel_app/service/koneksi.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/movie.dart';
import 'package:travel_app/widgets/search.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount;
  late List movies;
  late HttpService service;
  late List<Movie> allMovies;
  final String imgPath = 'https://image.tmdb.org/t/p/w500';
  TextEditingController searchController = TextEditingController();

  Future initialize() async {
    final MovieList = await service.getPopularMovies();
    setState(() {
      moviesCount = MovieList.length;
      movies = MovieList;
      allMovies = List.from(MovieList);
    });
  }

  @override
  void initState() {
    service = HttpService();
    moviesCount = 0;
    initialize();
    super.initState();
  }

  void searchMovies(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua film
      setState(() {
        movies = List.from(allMovies);
      });
    } else {
      // Jika query tidak kosong, filter film berdasarkan query
      final searchResults = allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        movies = searchResults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  searchMovies(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (context, int position) {
              if (position < movies.length) {
                final movie = movies[position];

                return Card(
                  elevation: 4.0,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetail(movie),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(imgPath + movie.posterPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Rating: ${movie.voteAverage.toString()}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    movie.overview,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox
                    .shrink(); // Mengembalikan widget kosong jika posisi melebihi panjang list
              }
            },
          )),
        ],
      ),
    );
  }
}
