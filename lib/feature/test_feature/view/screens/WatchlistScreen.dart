import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_assets.dart';
import 'package:movie_app/core/utils/app_colors.dart';

class WatchlistScreen extends StatelessWidget {
  final List movies;
  const WatchlistScreen({super.key, this.movies = const []});

  String? _imageUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    return 'https://image.tmdb.org/t/p/w500$path';
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = movies.isEmpty;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: GestureDetector(
            onTap: () => Scaffold.maybeOf(context)?.openDrawer(),
            child: SvgPicture.asset(AppIcons.save, color: AppColors.white),
          ),
        ),
        centerTitle: true,
        title: const Text('Watch list',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
      body: isEmpty
          ? const _WatchlistEmpty()
          : _WatchlistList(movies: movies, imageUrlBuilder: _imageUrl),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _WatchlistList extends StatelessWidget {
  final List movies;
  final String? Function(String?) imageUrlBuilder;
  const _WatchlistList({required this.movies, required this.imageUrlBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 80),
      itemCount: movies.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, index) {
        final m = movies[index];
        return _WatchlistItem(
          title: m.title ?? '',
          posterPath: m.posterPath,
          rating:
              m.voteAverage != null ? (m.voteAverage as num).toDouble() : null,
          genres: (m.genres != null)
              ? (m.genres as List).map((e) => e.name).join(', ')
              : '',
          year: (m.releaseDate != null && (m.releaseDate as String).isNotEmpty)
              ? (m.releaseDate as String).split('-').first
              : '',
          runtimeMinutes:
              (m.runtime != null && m.runtime > 0) ? m.runtime as int : null,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MovieDetailsPlaceholder(
                        movieId: (m.id ?? '').toString())));
          },
          imageUrlBuilder: imageUrlBuilder,
        );
      },
    );
  }
}

class _WatchlistItem extends StatelessWidget {
  final String title;
  final String? posterPath;
  final double? rating;
  final String genres;
  final String year;
  final int? runtimeMinutes;
  final VoidCallback onTap;
  final String? Function(String?) imageUrlBuilder;

  const _WatchlistItem({
    required this.title,
    required this.posterPath,
    required this.rating,
    required this.genres,
    required this.year,
    required this.runtimeMinutes,
    required this.onTap,
    required this.imageUrlBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final poster = imageUrlBuilder(posterPath);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: poster == null
                ? Container(width: 72, height: 110, color: AppColors.primary)
                : SvgPicture.asset(AppIcons.arrowBack,
                    width: 72, height: 110, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.rateColor.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              size: 14, color: AppColors.rateColor),
                          const SizedBox(width: 6),
                          Text(
                              rating != null ? rating!.toStringAsFixed(1) : '-',
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.movie,
                        size: 14, color: AppColors.whiteGrey),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(genres,
                            style: const TextStyle(color: AppColors.whiteGrey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: AppColors.whiteGrey),
                    const SizedBox(width: 6),
                    Text(year,
                        style: const TextStyle(color: AppColors.whiteGrey)),
                    const SizedBox(width: 12),
                    const Icon(Icons.access_time,
                        size: 14, color: AppColors.whiteGrey),
                    const SizedBox(width: 6),
                    Text(
                        runtimeMinutes != null
                            ? '$runtimeMinutes minutes'
                            : '-',
                        style: const TextStyle(color: AppColors.whiteGrey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WatchlistEmpty extends StatelessWidget {
  const _WatchlistEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)]),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6))
                ],
              ),
              child: Center(
                child: Icon(Icons.inbox_rounded,
                    size: 56, color: Colors.white.withOpacity(0.95)),
              ),
            ),
            const SizedBox(height: 18),
            const Text('There Is No Movie Yet!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Find your movie by type, title, categories, years, etc',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.whiteGrey, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.background,
      selectedItemColor: const Color(0xFF00A8FF),
      unselectedItemColor: AppColors.whiteGrey,
      showUnselectedLabels: true,
      currentIndex: 2,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border), label: 'Watch list'),
      ],
    );
  }
}

class MovieDetailsPlaceholder extends StatelessWidget {
  final String movieId;
  const MovieDetailsPlaceholder({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title:
              const Text('Detail', style: TextStyle(color: AppColors.white))),
      body: const Center(
          child: Text('Details placeholder',
              style: TextStyle(color: AppColors.white))),
    );
  }
}
