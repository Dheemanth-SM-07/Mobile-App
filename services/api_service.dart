import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        '${Constants.baseUrl}${Constants.popularMovies}?api_key=${Constants.apiKey}&page=$page'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final url = Uri.parse(
        '${Constants.baseUrl}${Constants.searchMovies}?api_key=${Constants.apiKey}&query=$query'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<MovieDetail> getMovieDetails(int movieId) async {
    try {
      final url = Uri.parse(
        '${Constants.baseUrl}${Constants.movieDetails}/$movieId?api_key=${Constants.apiKey}'
      );
      
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieDetail.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
