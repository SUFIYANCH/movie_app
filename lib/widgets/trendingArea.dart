import 'package:flutter/material.dart';
import 'package:movie_app/screens/details_page.dart';

import '../model/trending_movie_model.dart';

class TrendingNow extends StatelessWidget {
  final Result results;
  const TrendingNow({super.key, required this.results});
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(results),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          imgOriginal + results.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
