import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/model/search_model.dart';
import 'package:movie_app/providers/provider.dart';
import 'package:movie_app/service/api_service.dart';
import 'package:movie_app/utils/responsive.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  Apiservice apiservice = Apiservice();
  TextEditingController searchController = TextEditingController();
  Future<SearchModel?>? searchData;
  final String imgOriginal = "http://image.tmdb.org/t/p/original";
  final String imgMedium = "http://image.tmdb.org/t/p/w300";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: const Color(0xFF161616),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 70,
            backgroundColor: Colors.transparent,
            title: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              controller: searchController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (ref.watch(isSearchingProvider)) {
                        searchController.clear();
                        ref.read(isSearchingProvider.notifier).state = false;
                        apiservice.getSearchMovie(searchController.text);
                      } else {
                        if (searchController.text != '') {
                          searchData = apiservice
                              .getSearchMovie(searchController.text)
                              .then((value) {
                            ref.read(isSearchingProvider.notifier).state = true;
                            return null;
                          });
                        }
                      }
                    },
                    icon: Icon(ref.watch(isSearchingProvider)
                        ? Icons.clear
                        : Icons.search_rounded),
                  ),
                  suffixIconColor: Colors.white,
                  hintText: 'Search movies or series or person..',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.white))),
            ),
          ),
          body: ref.watch(searchProvider(searchController.text)).when(
                data: (data) {
                  if (data!.results!.isEmpty) {
                    return Center(
                      child: Text(
                        "Search Movies...",
                        style: TextStyle(
                            color: Colors.white, fontSize: R.rw(24, context)),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: data.results!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 200,
                          width: 160,
                          child: Image.network(
                            data.results![index].posterPath == null
                                ? data.results![index].profilePath == null
                                    ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                    : imgOriginal +
                                        data.results![index].profilePath!
                                : imgOriginal +
                                    data.results![index].posterPath!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
              )),
    );
  }
}
