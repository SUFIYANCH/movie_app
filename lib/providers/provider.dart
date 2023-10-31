import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/model/search_model.dart';
import 'package:movie_app/model/series_movie_model.dart';
import 'package:movie_app/model/trending_movie_model.dart';
import 'package:movie_app/service/api_service.dart';
import 'package:movie_app/service/firebase_service.dart';
import 'package:movie_app/service/storage_service.dart';

final userDataProvider = StateProvider<User?>((ref) {
  return null;
});

//auth

final authServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authState;
});

//api

final trendingProvider = FutureProvider<Trendingmoviemodel?>((ref) async {
  return Apiservice().getTrending();
});

final seriesProvider = FutureProvider<Seriesmoviemodel?>((ref) async {
  return Apiservice().getSeries();
});

final topratedProvider = FutureProvider<Trendingmoviemodel?>((ref) async {
  return Apiservice().getToprated();
});

final castProvider =
    FutureProvider.family.autoDispose<CastModel?, int>((ref, id) async {
  return Apiservice().getMovieCast(id);
});
final seriesCastProvider =
    FutureProvider.family.autoDispose<CastModel?, int>((ref, id) async {
  return Apiservice().getSeriesCast(id);
});
final searchProvider =
    FutureProvider.family<SearchModel?, String>((ref, query) async {
  return Apiservice().getSearchMovie(query);
});
final languageProvider =
    FutureProvider.family<Trendingmoviemodel?, String>((ref, language) async {
  return Apiservice().getLanguageMovie(language);
});

//search

final isSearchingProvider = StateProvider<bool>((ref) {
  return false;
});

//navigation index
final navigationIndexProvider = StateProvider<int>((ref) {
  return 0;
});

// slider index
final sliderIndexProvider = StateProvider<int>((ref) {
  return 0;
});

//storage
final storageProvider = FutureProvider.family<String?, File>((ref, file) async {
  return Storage.linkConverting(file);
});

// url

final imageUrlProvider = StateProvider<String?>((ref) {
  return null;
});
