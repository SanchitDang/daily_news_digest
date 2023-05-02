class Article {
  String title;
  String description;
  String imageUrl;
  String publishedAt;
  String source;

  Article(
      {
        required this.title,
        required this.description,
        required this.imageUrl,
        required this.publishedAt,
        required this.source,
      }
      );

  factory Article.fromJson(Map<String, dynamic> data) {
    return Article(
      title: data['title'],
      description: data['description'] ?? "Not Given",
      imageUrl: data['urlToImage'] ?? "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg",
      publishedAt: data['publishedAt'],
      source: data['source']['name'],
    );
  }
}
