import 'package:flutter/material.dart';
import 'package:movie_app/screens/details_page.dart';

import '../model/trending_movie_model.dart';

class TopratedMovies extends StatelessWidget {
  final Result topratedimg;
  const TopratedMovies({super.key, required this.topratedimg});
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(
          result: topratedimg,
        ),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          imgOriginal + topratedimg.posterPath.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
