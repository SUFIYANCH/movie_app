import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/search_model.dart';
import 'package:movie_app/model/series_movie_model.dart';
import 'package:movie_app/model/trending_movie_model.dart';

class Apiservice {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {"api_key": "af3ec5ac4cff3bf7a60c9069f46ed25e"},
  ));

  Future<Trendingmoviemodel?> getTrending() async {
    try {
      Response response = await dio.get("/movie/popular");
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return trendingmoviemodelFromJson(jsonResponse);
      }
    } on DioError catch (e) {
      print("$e");
    }
    return null;
  }

  Future<Seriesmoviemodel?> getSeries() async {
    try {
      Response response = await dio.get("/trending/tv/day");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return seriesmoviemodelFromJson(jsonResponse);
      }
    } on DioError catch (e) {
      print("$e");
    }
    return null;
  }

  Future<Trendingmoviemodel?> getToprated() async {
    try {
      Response response = await dio.get("/movie/top_rated");
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return trendingmoviemodelFromJson(jsonResponse);
      }
    } on DioError catch (e) {
      print("$e");
    }
    return null;
  }

  Future<CastModel?> getMovieCast(int id) async {
    try {
      Response response = await dio.get("/movie/$id/credits");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());

        var jsonResponse = json.encode(response.data);
        return castModelFromJson(jsonResponse);
      }
    } on DioError catch (e) {
      print("$e");
    }
    return null;
  }

  Future<SearchModel?> getSearchMovie(String query) async {
    try {
      Response response = await dio.get("/search/multi?query=$query");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());

        var jsonResponse = json.encode(response.data);
        return searchModelFromJson(jsonResponse);
      }
    } on DioError catch (e) {
      print("$e");
    }
    return null;
  }
}
