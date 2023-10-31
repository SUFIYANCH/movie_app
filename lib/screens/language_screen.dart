import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/utils/responsive.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  final String imgOriginal = "http://image.tmdb.org/t/p/original";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/movieslogo.png",
            width: R.rw(150, context),
          ),
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: "English",
              ),
              Tab(
                text: "Malayalam",
              ),
              Tab(
                text: "Hindi",
              ),
              Tab(
                text: "Tamil",
              ),
              Tab(
                text: "Telugu",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ref.watch(languageProvider("en")).when(
                  data: (data) {
                    if (data!.results.isEmpty) {
                      return const Center(
                        child: Text("No Movies with this language"),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: data.results.length,
                        padding: EdgeInsets.only(top: R.rh(10, context)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: R.rw(10, context),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: R.rw(4, context)),
                            width: R.rw(130, context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(R.rw(8, context)),
                            ),
                            child: Image.network(
                              data.results[index].posterPath == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                  : imgOriginal +
                                      data.results[index].posterPath.toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ref.watch(languageProvider("ml")).when(
                  data: (data) {
                    if (data!.results.isEmpty) {
                      return const Center(
                        child: Text("No Movies with this language"),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: data.results.length,
                        padding: EdgeInsets.only(top: R.rh(10, context)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: R.rw(10, context),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: R.rw(4, context)),
                            width: R.rw(130, context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(R.rw(8, context)),
                            ),
                            child: Image.network(
                              data.results[index].posterPath == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                  : imgOriginal +
                                      data.results[index].posterPath.toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ref.watch(languageProvider("hi")).when(
                  data: (data) {
                    if (data!.results.isEmpty) {
                      return const Center(
                        child: Text("No Movies with this language"),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: data.results.length,
                        padding: EdgeInsets.only(top: R.rh(10, context)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: R.rw(10, context),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: R.rw(4, context)),
                            width: R.rw(130, context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(R.rw(8, context)),
                            ),
                            child: Image.network(
                              data.results[index].posterPath == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                  : imgOriginal +
                                      data.results[index].posterPath.toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ref.watch(languageProvider("ta")).when(
                  data: (data) {
                    if (data!.results.isEmpty) {
                      return const Center(
                        child: Text("No Movies with this language"),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: data.results.length,
                        padding: EdgeInsets.only(top: R.rh(10, context)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: R.rw(10, context),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: R.rw(4, context)),
                            width: R.rw(130, context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(R.rw(8, context)),
                            ),
                            child: Image.network(
                              data.results[index].posterPath == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                  : imgOriginal +
                                      data.results[index].posterPath.toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ref.watch(languageProvider("te")).when(
                  data: (data) {
                    if (data!.results.isEmpty) {
                      return const Center(
                        child: Text("No Movies with this language"),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: data.results.length,
                        padding: EdgeInsets.only(top: R.rh(10, context)),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: R.rw(10, context),
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: R.rw(4, context)),
                            width: R.rw(130, context),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(R.rw(8, context)),
                            ),
                            child: Image.network(
                              data.results[index].posterPath == null
                                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                  : imgOriginal +
                                      data.results[index].posterPath.toString(),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
