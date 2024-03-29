import 'package:flutter/material.dart';
import 'package:movie_app/screens/series_detail_page.dart';
import '../model/series_movie_model.dart';

class Seriesmovies extends StatelessWidget {
  final Result seriesimg;
  const Seriesmovies({super.key, required this.seriesimg});
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SeriesDetailsPage(results: seriesimg),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          imgOriginal + seriesimg.posterPath.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
