import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/search_controller.dart';
import '../../../data/models/search_result_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (query) => context.read<SearchProvider>().updateQuery(query),
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }

          if (provider.query.isEmpty) {
            return _buildExploreGrid();
          }

          if (provider.searchResults.isEmpty) {
            return const Center(child: Text("No results found"));
          }

          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              final result = provider.searchResults[index];
              return ListTile(
                leading: _buildLeading(result),
                title: Text(result.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: result.subtitle != null ? Text(result.subtitle!) : null,
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLeading(SearchResult result) {
    if (result.type == SearchResultType.user && result.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(result.imageUrl!),
      );
    }
    
    IconData iconData = Icons.search;
    if (result.type == SearchResultType.tag) iconData = Icons.tag;
    if (result.type == SearchResultType.place) iconData = Icons.location_on_outlined;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(iconData, color: Colors.black),
    );
  }

  Widget _buildExploreGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 18,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: "https://picsum.photos/id/${index + 100}/300/300",
          fit: BoxFit.cover,
        );
      },
    );
  }
}
