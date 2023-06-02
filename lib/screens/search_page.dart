import 'package:flutter/material.dart';
import 'package:movie_app/model/search_model.dart';
import 'package:movie_app/service/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            style: TextStyle(color: Colors.white),
            controller: searchController,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (searchController.text != '') {
                        searchData =
                            apiservice.getSearchMovie(searchController.text);
                      }
                    });
                  },
                  icon: Icon(Icons.search_rounded),
                ),
                suffixIconColor: Colors.white,
                hintText: 'Search movies or series or person..',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2, color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 3, color: Colors.white))),
          ),
        ),
        body: FutureBuilder(
          future: searchData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Result> data = snapshot.data!.results!;
              return data.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: 160,
                          child: Image.network(
                            data[index].posterPath == null
                                ? data[index].profilePath == null
                                    ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019'
                                    : imgOriginal + data[index].profilePath!
                                : imgOriginal + data[index].posterPath!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
            } else {
              return const Center(
                child: Text(
                  'Search Movies',
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
