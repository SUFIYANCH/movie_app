import 'package:flutter/material.dart';
import 'package:movie_app/screens/details_page.dart';
import 'package:movie_app/utils/responsive.dart';

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
        builder: (context) => DetailsPage(
          result: results,
        ),
      )),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: R.rw(4, context)),
        width: R.rw(130, context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(R.rw(8, context)),
        ),
        child: Image.network(
          imgOriginal + results.posterPath.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
