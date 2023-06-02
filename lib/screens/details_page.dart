import 'package:flutter/material.dart';
import 'package:movie_app/colors/colors.dart';

import '../model/trending_movie_model.dart';
import '../service/api_service.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final Result result;
  DetailsPage(this.result, {super.key});

  Apiservice apiservice = Apiservice();
  @override
  Widget build(BuildContext context) {
    final String imgOriginal = "http://image.tmdb.org/t/p/original";

    return Scaffold(
        backgroundColor: Color.fromARGB(221, 14, 13, 13),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white38,
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.36,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    ShaderMask(
                      shaderCallback: ((Rect bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.7, 1],
                              colors: [Colors.transparent, Colors.black])
                          .createShader(bounds)),
                      blendMode: BlendMode.srcATop,
                      child: Image.network(
                        imgOriginal + result.posterPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 20,
                        left: 24,
                        child: Text(
                          "Preview",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Text(
                            result.title,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: tbWhite,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Icon(
                          Icons.cloud_download,
                          color: tbWhite,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "95% match",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                                children: [
                              TextSpan(
                                  text: "    2023    2h 49m    R    HD",
                                  style: TextStyle(color: tbAsh))
                            ])),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.thumb_up,
                            color: Colors.black,
                            size: 12,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Most Liked",
                          style: TextStyle(color: tbWhite, fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(), backgroundColor: tbAsh),
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_arrow,
                            size: 16,
                          ),
                          label: Text("Play")),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prolog",
                          style: TextStyle(
                              color: tbWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          child: Text(
                            result.overview,
                            maxLines: 6,
                            style: TextStyle(
                                color: tbAsh, fontSize: 12, height: 1.4),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Top Cast",
                          style: TextStyle(
                              color: tbWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 76,
                      child: Center(
                        child: FutureBuilder(
                          future: apiservice.getMovieCast(result.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data!.cast!.length);
                              return ListView.separated(
                                itemCount: snapshot.data!.cast!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => topcastArea(
                                  topcasting:
                                      snapshot.data!.cast![index].profilePath ==
                                              null
                                          ? null
                                          : imgOriginal +
                                              snapshot.data!.cast![index]
                                                  .profilePath!,
                                  title: snapshot.data!.cast![index].name,
                                  subtitle:
                                      snapshot.data!.cast![index].character,
                                ),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(width: 10),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
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
          style: TextStyle(color: tbWhite, fontSize: 14),
        ),
        Text(
          subtitle,
          style: TextStyle(color: tbAsh, fontSize: 12),
        )
      ],
    );
  }
}
