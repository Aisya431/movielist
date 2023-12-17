import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/search.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: 2,
      items: [
        Icon(Icons.person_outline, size: 30), // index 0
        Icon(Icons.favorite_outline, size: 30),
        Icon(
          Icons.home,
          size: 30,
          color: Colors.redAccent,
        ),
        Icon(Icons.location_city_outlined, size: 30),
        InkWell(child: Icon(
            Icons.search,
            color: Colors.black,
            size: 28,
          ),
          onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
            // Tambahkan kode yang ingin dijalankan saat ikon ditekan di sini
            print('Icon ditekan');
          },
        )
      ],
    );
  }
}
