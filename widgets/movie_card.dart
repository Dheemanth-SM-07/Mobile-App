import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';
import '../services/storage_service.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback? onFavoriteChanged;

  const MovieCard({
    super.key,
    required this.movie,
    this.onFavoriteChanged,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  final StorageService _storage = StorageService();
  bool _isFavorite = false;
  bool _isInWatchlist = false;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final fav = await _storage.isFavorite(widget.movie.id);
    final watch = await _storage.isInWatchlist(widget.movie.id);
    setState(() {
      _isFavorite = fav;
      _isInWatchlist = watch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movieId: widget.movie.id),
          ),
        );
      },
      child: Card(
        color: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  widget.movie.posterUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: widget.movie.posterUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        )
                      : Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(Icons.movie, size: 50),
                          ),
                        ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.white,
                          ),
                          onPressed: () async {
                            if (_isFavorite) {
                              await _storage.removeFromFavorites(widget.movie.id);
                            } else {
                              await _storage.addToFavorites(widget.movie.id);
                            }
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                            widget.onFavoriteChanged?.call();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _isInWatchlist
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: _isInWatchlist ? Colors.amber : Colors.white,
                          ),
                          onPressed: () async {
                            if (_isInWatchlist) {
                              await _storage.removeFromWatchlist(widget.movie.id);
                            } else {
                              await _storage.addToWatchlist(widget.movie.id);
                            }
                            setState(() {
                              _isInWatchlist = !_isInWatchlist;
                            });
                            widget.onFavoriteChanged?.call();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        widget.movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
