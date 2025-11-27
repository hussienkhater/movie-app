class SimilarMovie {
  final int id;
  final String title;
  final String? posterPath;

  SimilarMovie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory SimilarMovie.fromJson(Map<String, dynamic> json) {
    return SimilarMovie(
      id: json['id'],
      title: json['title'] ?? '',
      posterPath: json['poster_path'],
    );
  }
}
