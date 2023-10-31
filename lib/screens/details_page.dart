import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/responsive.dart';

import '../model/trending_movie_model.dart';

class DetailsPage extends ConsumerWidget {
  final Result result;

  const DetailsPage({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String imgOriginal = "http://image.tmdb.org/t/p/original";

    DateTime dateTime = DateTime.parse(result.releaseDate.toString());

    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    return Scaffold(
        backgroundColor: const Color.fromARGB(221, 14, 13, 13),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                title: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height * 0.38,
                flexibleSpace: ref.watch(trendingProvider).when(
                      data: (data) {
                        return FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              ShaderMask(
                                shaderCallback: ((Rect bounds) =>
                                    const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.7,
                                          1
                                        ],
                                        colors: [
                                          Colors.transparent,
                                          Colors.black
                                        ]).createShader(bounds)),
                                blendMode: BlendMode.srcATop,
                                child: Image.network(
                                  imgOriginal + result.posterPath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: R.rh(20, context),
                                  left: R.rw(24, context),
                                  child: Text(
                                    "Preview",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: R.rw(16, context)),
                                  ))
                            ],
                          ),
                        );
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    left: R.rw(20, context),
                    right: R.rw(20, context),
                    top: R.rh(10, context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        result.title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: R.rw(22, context),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: R.rh(18, context),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: R.rw(8, context),
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.date_range,
                            color: Colors.black,
                            size: R.rw(12, context),
                          ),
                        ),
                        SizedBox(
                          width: R.rw(10, context),
                        ),
                        Text(
                          "Release Date : $formattedDate ",
                          style: TextStyle(
                              color: Colors.red, fontSize: R.rw(14, context)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: R.rh(10, context),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: R.rw(8, context),
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.language,
                            color: Colors.black,
                            size: R.rw(12, context),
                          ),
                        ),
                        SizedBox(
                          width: R.rw(10, context),
                        ),
                        Text(
                          "Language : ${result.originalLanguage == "en" ? result.originalLanguage == "ml" ? result.originalLanguage == "ta" ? result.originalLanguage == "hi" ? result.originalLanguage == "te" ? "Telungu" : "Hindi" : "Tamil" : "Malayalam" : "English" : result.originalLanguage} ",
                          style: TextStyle(
                              color: Colors.blue, fontSize: R.rw(14, context)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: R.rh(10, context),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: R.rw(8, context),
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.thumb_up,
                            color: Colors.black,
                            size: R.rw(12, context),
                          ),
                        ),
                        SizedBox(
                          width: R.rw(10, context),
                        ),
                        Text(
                          "Rating : ${result.voteAverage.toInt()}/10 ",
                          style: TextStyle(
                              color: Colors.green, fontSize: R.rw(14, context)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: R.rh(26, context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overview",
                          style: TextStyle(
                              color: tbWhite,
                              fontSize: R.rw(20, context),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: R.rh(10, context),
                        ),
                        SizedBox(
                          height: R.rh(100, context),
                          child: Text(
                            result.overview,
                            maxLines: 6,
                            style: TextStyle(
                                color: tbAsh,
                                fontSize: R.rw(12, context),
                                height: 1.4),
                          ),
                        ),
                        SizedBox(
                          height: R.rh(12, context),
                        ),
                        Text(
                          "Top Cast",
                          style: TextStyle(
                              color: tbWhite,
                              fontSize: R.rw(20, context),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: R.rh(12, context),
                    ),
                    SizedBox(
                      height: R.rh(76, context),
                      child: Center(
                          child: ref.watch(castProvider(result.id)).when(
                                data: (data) {
                                  return ListView.separated(
                                    itemCount: data!.cast!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      log("details data:${data.cast![index].name}");

                                      return topcastArea(
                                        topcasting: imgOriginal +
                                            data.cast![index].profilePath!,
                                        title: data.cast![index].name,
                                        subtitle: data.cast![index].character,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(width: R.rw(10, context)),
                                  );
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
                    ),
                    SizedBox(
                      height: R.rh(20, context),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Column topcastArea({String? topcasting, title, subtitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        topcasting == null
            ? const CircleAvatar(
                child: Icon(Icons.account_circle),
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(topcasting),
              ),
        Text(
          title,
          style: const TextStyle(color: tbWhite, fontSize: 14),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: tbAsh, fontSize: 12),
        )
      ],
    );
  }
}
