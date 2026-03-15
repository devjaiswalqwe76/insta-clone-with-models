import 'package:flutter/material.dart';
import '../../../data/models/search_result_model.dart';

class SearchProvider extends ChangeNotifier {
  String _query = "";
  List<SearchResult> _searchResults = [];
  bool _isLoading = false;

  String get query => _query;
  List<SearchResult> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  final List<SearchResult> _mockData = [
    SearchResult(id: "1", title: "flutter_dev", subtitle: "Flutter Developer", imageUrl: "https://i.pravatar.cc/150?img=1", type: SearchResultType.user),
    SearchResult(id: "2", title: "dart_lang", subtitle: "Programming Language", imageUrl: "https://i.pravatar.cc/150?img=2", type: SearchResultType.user),
    SearchResult(id: "3", title: "#flutter", subtitle: "1.2M posts", type: SearchResultType.tag),
    SearchResult(id: "4", title: "#dart", subtitle: "500K posts", type: SearchResultType.tag),
    SearchResult(id: "5", title: "Mountain View", subtitle: "California, USA", type: SearchResultType.place),
  ];

  void updateQuery(String newQuery) {
    _query = newQuery;
    if (_query.isEmpty) {
      _searchResults = [];
    } else {
      _isLoading = true;
      notifyListeners();

      // Simple search logic
      _searchResults = _mockData.where((item) =>
          item.title.toLowerCase().contains(_query.toLowerCase()) ||
          (item.subtitle?.toLowerCase().contains(_query.toLowerCase()) ?? false)
      ).toList();

      _isLoading = false;
    }
    notifyListeners();
  }
}
