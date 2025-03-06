import 'package:film/models/movie.dart';
import 'package:film/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> _favoriteMovie = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: _favoriteMovie.length,
        itemBuilder: (context, index) {
          final Movie movie = _favoriteMovie[index];
           return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: Image.network(
                  movie.posterPath != ''
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                      : 'https://placehold.co/50x75?text=No+Image',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover),
              title: Text(movie.title),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie)));
              },
            ),
          );
        },
      ),
    );
  }
}
