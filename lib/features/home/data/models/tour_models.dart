class Tour {
  final int id;
  final String title;
  final String url;
  final String? image;
  final String excerpt;

  Tour({
    required this.id,
    required this.title,
    required this.url,
    this.image,
    required this.excerpt,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['ID'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      image:
          (json['image'] != null && json['image'] != false)
              ? json['image']
              : null,
      excerpt: json['excerpt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'title': title,
      'url': url,
      'image': image,
      'excerpt': excerpt,
    };
  }
}
