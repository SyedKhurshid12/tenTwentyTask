import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:tentwenty_task/models/movie_detail_model.dart';


@immutable
abstract class MovieDetailState {}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String errorMessage;

  MovieDetailError({
    required this.errorMessage,
  });
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movieDetailModel;

  MovieDetailLoaded({required this.movieDetailModel});
}
