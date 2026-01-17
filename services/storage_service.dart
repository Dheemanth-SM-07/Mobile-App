import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static const String _favoritesKey = 'favorites';
  static const String _watchlistKey = 'watchlist';

  Future<void> addToFavorites(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(movieId.toString())) {
      favorites.add(movieId.toString());
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFromFavorites(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.remove(movieId.toString());
    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.map((id) => int.parse(id)).toList();
  }

  Future<bool> isFavorite(int movieId) async {
    final favorites = await getFavorites();
    return favorites.contains(movieId);
  }

  Future<void> addToWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList(_watchlistKey) ?? [];
    if (!watchlist.contains(movieId.toString())) {
      watchlist.add(movieId.toString());
      await prefs.setStringList(_watchlistKey, watchlist);
    }
  }

  Future<void> removeFromWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList(_watchlistKey) ?? [];
    watchlist.remove(movieId.toString());
    await prefs.setStringList(_watchlistKey, watchlist);
  }

  Future<List<int>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchlist = prefs.getStringList(_watchlistKey) ?? [];
    return watchlist.map((id) => int.parse(id)).toList();
  }

  Future<bool> isInWatchlist(int movieId) async {
    final watchlist = await getWatchlist();
    return watchlist.contains(movieId);
  }
}
