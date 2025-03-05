import 'package:film/models/movie.dart';
import 'package:film/services/api_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchMovie);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchMovie() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResult.clear();
      });

      final List<Map<String, dynamic>> searchData =
          await _apiService.searchMovies(_searchController.text);
      setState(() {
        _searchResult = searchData.map((e) => Movie.fromJson(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                          hintText: 'Search Movie', border: InputBorder.none),
                    ),
                  ),
                  Visibility(
                    visible: _searchController.text.isNotEmpty,
                    child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchResult.clear();
                          });
                        },
                        icon: const Icon(Icons.clear)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              itemBuilder: (context, index) {},
            )
          ],
        ),
      ),
    );
  }
}
