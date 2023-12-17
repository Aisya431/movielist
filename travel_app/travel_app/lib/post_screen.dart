import 'package:flutter/material.dart';
import 'package:travel_app/models/movie.dart';
//import 'package:listmovie/pages/movie_list.dart';


class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path = 'https://images.freeimages.com/images/large=previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: ListView(
        children: [
          Container(
            height: height / 1.5,
            child: Image.network(path, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
          Text(
            movie.overview,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan logika untuk menambahkan ke favorit di sini
                },
                icon: Icon(Icons.favorite),
                label: Text('Add to Favorites'),
              ),
            ],
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}