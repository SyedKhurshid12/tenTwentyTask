import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:tentwenty_task/models/get_movie_trailer_model.dart';
import 'package:tentwenty_task/models/movie_detail_model.dart';


@immutable
abstract class GetMovieTrailerState {}

class GetMovieTrailerInitialState extends GetMovieTrailerState {}

class GetMovieTrailerError extends GetMovieTrailerState {
  final String errorMessage;

  GetMovieTrailerError({
    required this.errorMessage,
  });
}

class GetMovieTrailerLoading extends GetMovieTrailerState {}

class GetMovieTrailerLoaded extends GetMovieTrailerState {
  final MovieTrailerModel movieTrailerModel;

  GetMovieTrailerLoaded({required this.movieTrailerModel});
}
