import 'package:flutter/material.dart';
import 'package:travel_app/models/movie.dart';
import 'package:travel_app/post_screen.dart';
import 'package:travel_app/service/koneksi.dart';
import 'package:travel_app/widgets/home_app_bar.dart';
import 'package:travel_app/widgets/home_bottom_bar.dart';
import 'package:travel_app/screens/movielist.dart';
// Assuming you have an HttpService class

class HomePage extends StatelessWidget {
  final httpService = HttpService(); // Create an instance of HttpService

  var category = [
    'Popular Movie',
    'Most Viewed',
    'Favorites',
    'New Movie',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: HomeAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Welcome Text and Description
                Container(
                  height: 150,
                  width: 500,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nikmati berbagai film dari kategori berbeda.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = 0; index < category.length; index++)
                          InkWell(
                            onTap: () {
                              print('Category tapped: ${category[index]}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieList(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 90,
                              width: 120,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  category[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Fetch movies based on the selected category
                FutureBuilder<List<Movie>>(
                  future: httpService
                      .getPopularMovies(), // You can change this to fetch data for other categories
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator while fetching data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the fetched movie data
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final movie = snapshot.data![index];
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Implement navigation to the movie details page
                                    // Use the movie data (e.g., movie.id) to fetch detailed information
                                  },
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}'), // Replace with the actual URL for the movie poster
                                        fit: BoxFit.cover,
                                        opacity: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(Icons.more_vert, size: 30),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      movie.voteAverage.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
