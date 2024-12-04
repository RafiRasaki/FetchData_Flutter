class Game {
    final int id;
    final String title;
    final String thumbnail;
    final String shortDescription;
    final String gameUrl;
    final String genre;
    final String platform;
    final String publisher;
    final String developer;
    final DateTime releaseDate;
    final String freetogameProfileUrl;

    Game({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.shortDescription,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
    };
}
