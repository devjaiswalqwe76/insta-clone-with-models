enum SearchResultType { user, tag, place }

class SearchResult {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final SearchResultType type;

  SearchResult({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    required this.type,
  });
}
