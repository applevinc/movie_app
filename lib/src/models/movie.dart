class Movie {
  final String title;
  final String poster;
  final String description;
  final DateTime releaseDate;
  final List<int> genres;
  final double rating;

  Movie({
    required this.title,
    required this.poster,
    required this.description,
    required this.releaseDate,
    required this.genres,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      poster: 'https://image.tmdb.org/t/p/w500${json["poster_path"]}',
      description: json["overview"],
      releaseDate: DateTime.parse(json["release_date"]),
      genres: List<int>.from(json["genre_ids"].map((x) => x)),
      rating: json["vote_average"].toDouble(),
    );
  }
}
