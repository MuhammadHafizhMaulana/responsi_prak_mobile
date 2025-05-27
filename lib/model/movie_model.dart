class Movie{
  final int id;
  final String title;
  final String imgUrl;
  final String genre;

  Movie({
  required this.id,
  required this.title,
  required this.imgUrl,
  required this.genre
});

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      title: json['title'] ?? "no title",
      imgUrl: json['images'] ?? 'https://placehold.co/600x400',
      genre: (json['genre'] != null && json['genre'] is List)
      ? (json['genre'] as List).join(', ')
      : "-",

    );
  }

}

