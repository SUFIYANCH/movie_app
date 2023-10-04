import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/trending_movie_model.dart';
import 'package:movie_app/screens/details_page.dart';
import 'package:movie_app/screens/search_page.dart';
import 'package:movie_app/widgets/seriesArea.dart';
import 'package:movie_app/widgets/topratedArea.dart';
import 'package:movie_app/widgets/trendingArea.dart';
import 'package:movie_app/service/api_service.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Apiservice apiservice = Apiservice();
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";
  int currentIndex = 0;
  File? file;
  void pickImgWithCamera() async {
    try {
      final fileimg = await ImagePicker().pickImage(source: ImageSource.camera);

      setState(() {
        file = File(fileimg!.path);
      });
    } on Exception catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  void pickImgWithGallery() async {
    try {
      final fileimg =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        file = File(fileimg!.path);
      });
    } on Exception catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: apiservice.getTrending(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var result = snapshot.data!.results;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.black,
                      pinned: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  title: const Text('Choose image from'),
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.black,
                                          child: IconButton(
                                              onPressed: () =>
                                                  pickImgWithCamera(),
                                              icon: const Icon(
                                                  Icons.camera_alt_outlined)),
                                        ),
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.black,
                                          child: IconButton(
                                              onPressed: () =>
                                                  pickImgWithGallery(),
                                              icon: const Icon(Icons.photo)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: file == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/donnieYen.jpg'),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.white38,
                                    backgroundImage: FileImage(file!),
                                  ),
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white38,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchPage(),
                                        ));
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                      // I used this to show background image
                      expandedHeight: MediaQuery.of(context).size.height * 0.6,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) =>
                                  const LinearGradient(
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
                                itemCount: result.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Image.network(
                                    imgOriginal + result[index].backdropPath,
                                    fit: BoxFit.cover,
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  autoPlay: true,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  viewportFraction: 1,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    currentIndex = index;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: buildBody(result),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Column buildBody(List<Result> result) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Play'),
            ),
            const SizedBox(width: 30),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => DetailsPage(result[currentIndex]))));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 5,
                ),
              ),
              child: const Text('Details'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Now",
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              Text(
                "see all",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 172,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return TrendingNow(results: result[index]);
              }),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Series",
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              Text(
                "see all",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 172,
          child: FutureBuilder(
              future: apiservice.getSeries(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var seriesData = snapshot.data!.results;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: seriesData.length,
                      itemBuilder: (context, index) {
                        return Seriesmovies(
                          seriesimg: seriesData[index],
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top rated",
                style: TextStyle(fontSize: 26, color: Colors.white),
              ),
              Text(
                "see all",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 172,
          child: FutureBuilder(
            future: apiservice.getToprated(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var topratedData = snapshot.data!.results;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return KoreanSeries(
                        koreanimg: topratedData[index],
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
