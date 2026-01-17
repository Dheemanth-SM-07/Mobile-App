import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/movie_card.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final ApiService _apiService = ApiService();
  final StorageService _storage = StorageService();
  
  List<Movie> _watchlistMovies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final watchlistIds = await _storage.getWatchlist();
      
      if (watchlistIds.isEmpty) {
        setState(() {
          _watchlistMovies = [];
          _isLoading = false;
        });
        return;
      }

      // Fetch movie details for each watchlist ID
      List<Movie> movies = [];
      for (int id in watchlistIds) {
        try {
          final movie = await _apiService.getMovieDetails(id);
          movies.add(movie);
        } catch (e) {
          continue;
        }
      }

      setState(() {
        _watchlistMovies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.red),
      );
    }

    if (_watchlistMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 80, color: Colors.grey[600]),
            const SizedBox(height: 16),
            const Text(
              'No movies in watchlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Add movies to watch later',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadWatchlist,
      color: Colors.red,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _watchlistMovies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            movie: _watchlistMovies[index],
            onFavoriteChanged: _loadWatchlist,
          );
        },
      ),
    );
  }
}
