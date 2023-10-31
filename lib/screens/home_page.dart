import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/screens/details_page.dart';
import 'package:movie_app/utils/responsive.dart';
import 'package:movie_app/widgets/series_area.dart';
import 'package:movie_app/widgets/toprated_area.dart';
import 'package:movie_app/widgets/trending_area.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ref.watch(trendingProvider).when(
          data: (data) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: EdgeInsets.only(left: R.rw(10, context)),
                    child: GestureDetector(
                      onTap: () {
                        ref.read(navigationIndexProvider.notifier).state = 3;
                      },
                      child: ref.watch(imageUrlProvider) == null
                          ? Icon(
                              Icons.person,
                              size: R.rw(30, context),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white38,
                              backgroundImage: NetworkImage(
                                  ref.watch(imageUrlProvider).toString()),
                            ),
                    ),
                  ),
                  title: Image.asset(
                    "assets/movieslogo.png",
                    width: R.rw(150, context),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: R.rw(10, context)),
                      child: CircleAvatar(
                          backgroundColor: Colors.white38,
                          child: IconButton(
                              onPressed: () {
                                ref
                                    .read(navigationIndexProvider.notifier)
                                    .state = 1;
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ))),
                    ),
                  ],
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  pinned: true,

                  // I used this to show background image
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) => const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.7, 1],
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ).createShader(bounds),
                          blendMode: BlendMode.srcATop,
                          child: CarouselSlider.builder(
                            itemCount: data!.results.length,
                            itemBuilder: (context, index, realIndex) {
                              return Image.network(
                                imgOriginal +
                                    data.results[index].backdropPath.toString(),
                                fit: BoxFit.cover,
                              );
                            },
                            options: CarouselOptions(
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 1),
                              autoPlay: true,
                              height: MediaQuery.of(context).size.height * 0.6,
                              viewportFraction: 1,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                ref.watch(sliderIndexProvider.notifier).state =
                                    index;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => DetailsPage(
                                      result: data.results[
                                          ref.watch(sliderIndexProvider)],
                                    ))));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              width: 1,
                              color: Colors.white,
                            ),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              horizontal: R.rw(20, context),
                              vertical: R.rh(5, context),
                            ),
                          ),
                          child: const Text('Details'),
                        ),
                      ),
                      SizedBox(height: R.rh(20, context)),
                      Text(
                        "Trending Now",
                        style: TextStyle(
                            fontSize: R.rw(26, context), color: Colors.white),
                      ),
                      SizedBox(height: R.rh(20, context)),
                      SizedBox(
                        height: R.rh(172, context),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.results.length,
                            itemBuilder: (context, index) {
                              return TrendingNow(results: data.results[index]);
                            }),
                      ),
                      SizedBox(height: R.rh(30, context)),
                      Text(
                        "Series",
                        style: TextStyle(
                            fontSize: R.rw(26, context), color: Colors.white),
                      ),
                      SizedBox(
                        height: R.rh(20, context),
                      ),
                      SizedBox(
                          height: R.rh(172, context),
                          child: ref.watch(seriesProvider).when(
                                data: (data) {
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data!.results.length,
                                      itemBuilder: (context, index) {
                                        return Seriesmovies(
                                          seriesimg: data.results[index],
                                        );
                                      });
                                },
                                error: (error, stackTrace) {
                                  return const Center(
                                    child: Text("Something Went Wrong"),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )),
                      SizedBox(
                        height: R.rh(30, context),
                      ),
                      Text(
                        "Top rated",
                        style: TextStyle(
                            fontSize: R.rw(26, context), color: Colors.white),
                      ),
                      SizedBox(
                        height: R.rh(20, context),
                      ),
                      SizedBox(
                          height: R.rh(172, context),
                          child: ref.watch(topratedProvider).when(
                            data: (data) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data!.results.length,
                                  itemBuilder: (context, index) {
                                    return TopratedMovies(
                                      topratedimg: data.results[index],
                                    );
                                  });
                            },
                            error: (error, stackTrace) {
                              return const Center(
                                child: Text("Something Went Wrong"),
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("Something Went Wrong"),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
