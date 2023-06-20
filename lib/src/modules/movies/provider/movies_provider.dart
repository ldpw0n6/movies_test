import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movies_test/src/domain/models/credits_response.dart';
import 'package:movies_test/src/domain/models/movie.dart';
import 'package:movies_test/src/domain/models/movie_details.dart';
import 'package:movies_test/src/domain/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'f54ab2aa25ccf96c6cfea4d196e0ac39';
  final String _language = 'es-ES';
  bool isRequesting = true;

  int _popularPage = 0;

  List<Movie> popularMovies = [];
  MovieDetails? movieDetails;
  Map<int, List<Cast>> movieCast = {};

  void updateView() => notifyListeners();

  Future<void> getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', page: _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    isRequesting = false;
  }

  Future<String> _getJsonData(String endpoint, {int page = 1}) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  Future<void> getMovieDetail(int id) async {
    movieDetails = null;
    final jsonData = await _getMovieDetailData('3/movie/$id');
    final detailsResponse = MovieDetails.fromRawJson(jsonData);
    movieDetails = detailsResponse;
  }

  Future<String> _getMovieDetailData(String endpoint) async {
    final url = Uri.https(
        _baseUrl, endpoint, {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    return response.body;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) {
      return movieCast[movieId]!;
    } else {
      final jsonData = await _getJsonData('3/movie/$movieId/credits');
      final creditsResponse = CreditsResponse.fromJson(jsonData);
      movieCast[movieId] = creditsResponse.cast;
      return creditsResponse.cast;
    }
  }
}
