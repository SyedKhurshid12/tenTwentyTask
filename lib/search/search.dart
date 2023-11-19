import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tentwenty_task/config/colors.dart';
import 'package:tentwenty_task/config/const_url.dart';
import 'package:tentwenty_task/models/upcoming_movie_model.dart';
import 'package:tentwenty_task/movie_home/movie_detail_screen.dart';

class Search extends StatefulWidget {
  final UpcomingMovieModel model;
  const Search({super.key,required this.model});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<UpcomingMovieModelResults?>? filter = [];


  @override
  Widget build(BuildContext context) {
    print(filter?.length);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          padding:const  EdgeInsets.only(top: 60 ,left: 10,right: 10), // Adjust the bottom padding as needed
          color: Colors.white, // Set the desired background color
          child: TextField(
            controller: searchController,
            textAlignVertical: TextAlignVertical.top,

            keyboardType: TextInputType.text,


            onChanged: (String? value) {
              final searchText = value?.toLowerCase();

              setState(() {
                filter = widget.model.results?.where((movie) =>
                movie?.originalTitle?.toLowerCase().contains(searchText!) ?? false
                ).toList();
              });
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:  BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:  BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),

              ),
              filled: true,

              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xffA7A7A7),
              ),
              hintText: "Tv Show, Movie, and more",
              prefixIcon: Icon(Icons.search, color: blackColor),
              suffixIcon: IconButton(
                icon: SvgPicture.asset("assets/remove.svg",height: 20, color: blackColor),
                onPressed: () {
                  Navigator.pop(context);
                  // Clear the text or perform cancel action
                },
              ),

              fillColor: primary,
            ),
          ),
        ),
      ),
      // Replace YourBodyWidget with the actual content of the body
      body: Column(
        children: [
          filter!.isEmpty?
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
              physics: const ScrollPhysics(),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0

              ),
              itemCount: widget.model.results?.length ?? 0, // Replace with your actual list length
              itemBuilder: (context, index) {
                // Replace the next line with the widget you want to build for each item
                   final imageUrl =widget. model.results?[index]?.posterPath ?? "";

                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              imageUrl: "$imageBaseUrl$imageUrl",
                              movieId:
                              widget.model.results?[index]?.id.toString() ??
                                  "",
                            ),
                          ),
                        );
                      },
                      child: SizedBox(

                        width: 300,
                        child: Container(
                          width:300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "$imageBaseUrl$imageUrl"),
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.overlay,
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 18.0,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.model.results?[index]?.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                          ),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );;
              },
            ),
          ):
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
              physics: const ScrollPhysics(),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0

              ),
              itemCount: filter?.length ?? 0, // Replace with your actual list length
              itemBuilder: (context, index) {
                // Replace the next line with the widget you want to build for each item
                final imageUrl =filter?[index]?.posterPath ?? "";

                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              imageUrl: "$imageBaseUrl$imageUrl",
                              movieId:
                              filter?[index]?.id.toString() ??
                                  "",
                            ),
                          ),
                        );
                      },
                      child: SizedBox(

                        width: 300,
                        child: Container(
                          width:300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  "$imageBaseUrl$imageUrl"),
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.overlay,
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 18.0,
                      child: SingleChildScrollView(
                        child: Text(
                          filter?[index]?.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          strutStyle: const StrutStyle(
                            forceStrutHeight: true,
                          ),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );;
              },
            ),
          ),

        ],
      ),
    );

  }

}

