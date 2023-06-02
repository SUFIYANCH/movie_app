import 'package:flutter/material.dart';
import 'package:movie_app/screens/details_page.dart';

import '../model/trending_movie_model.dart';

class KoreanSeries extends StatelessWidget {
  final Result koreanimg;
  const KoreanSeries({super.key, required this.koreanimg});
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(koreanimg),
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.network(
          imgOriginal + koreanimg.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
