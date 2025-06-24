import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteProvider =
    StateNotifierProvider.family<FavoriteNotifier, bool, int>((ref, movieId) {
      final isarRepository = ref.watch(localStorageRepositoryProvider);
      return FavoriteNotifier(isarRepository, movieId);
    });

class FavoriteNotifier extends StateNotifier<bool> {
  final LocalStorageRepository _isarRepostiroy;
  final int _movieId;

  FavoriteNotifier(this._isarRepostiroy, this._movieId) : super(false) {
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await _isarRepostiroy.isMovieFavorite(_movieId);
    state = isFavorite;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await _isarRepostiroy.toggleFavorite(movie);
    state = !state;
  }
}
