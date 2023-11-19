import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_task/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwenty_task/bloc/upcoming_movie_bloc/upcoming_movie_event.dart';
import 'package:tentwenty_task/config/const_url.dart';
import 'package:tentwenty_task/models/upcoming_movie_model.dart';
import 'package:tentwenty_task/movie_home/movie_detail_screen.dart';
import 'package:tentwenty_task/search/search.dart';

import '../bloc/upcoming_movie_bloc/upcoming_movie_state.dart';
import '../config/colors.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  UpcomingMovieBloc upcomingMovieBloc = UpcomingMovieBloc();
  UpcomingMovieModel? upcomingMovieModel;

  @override
  void initState() {
    // TODO: implement initState
    upcomingMovieBloc.add(GetUpcomingMovieList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // Adjust the horizontal padding as needed
          child: Text(
            "Watch",
            style: TextStyle(
                fontFamily: "Poppins",
                color: blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
        actions:  [
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(

                      builder: (context) =>  Search(model: upcomingMovieModel!,)));

            },
            child: const Padding(
              padding: EdgeInsets.only(right: 28.0),
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: BlocProvider(
          create: (_) => upcomingMovieBloc,
          child: BlocListener<UpcomingMovieBloc, UpcomingMovieState>(
              listener: (context, state) {
            if (state is UpcomingMovieError) {
            } else if (state is UpcomingMovieLoaded) {}
          }, child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
            builder: (context, state) {
              if (state is UpcomingMovieInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UpcomingMovieLoaded) {
                upcomingMovieModel = state.upcomingMovieModel;

                return _buildMovieList(context, state.upcomingMovieModel);
              } else {
                return Container();
              }
              return Container();
            },
          ))),
    );
  }

  Widget _buildMovieList(BuildContext context, UpcomingMovieModel model) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: double.infinity,
        // Set the height of your outer container as needed
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemCount: model.results?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  final imageUrl = model.results?[index]?.posterPath ?? "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Stack(
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
                                      model.results?[index]?.id.toString() ??
                                          "",
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
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
                        ),
                        Positioned(
                          bottom: 10,
                          left: 18.0,
                          child: SingleChildScrollView(
                            child: Text(
                              model.results?[index]?.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(
                                forceStrutHeight: true,
                              ),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
