import 'dart:convert';

import 'package:film/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  Future<void> _checkIsFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.containsKey('movie_${widget.movie.id}');
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        final String movieJson = jsonEncode(widget.movie.toJson());
        prefs.setString('movie_${widget.movie}', movieJson);
        List<String> favoriteMovieIds =
            prefs.getStringList('favoriteMovie') ?? [];
        favoriteMovieIds.add(widget.movie.toString());
        prefs.setStringList('favoriteMovie', favoriteMovieIds);
      } else {
        final String movieJson = jsonEncode(widget.movie.toJson());
        prefs.remove('movie_${widget.movie}');
        List<String> favoriteMovieIds =
            prefs.getStringList('favoriteMovie') ?? [];
        favoriteMovieIds.remove(widget.movie.toString());
        prefs.setStringList('favoriteMovie', favoriteMovieIds);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    child: IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        )))
              ]),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Overview: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.movie.overview),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Release Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.movie.releaseDate)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Rating",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.movie.voteAverage.toString())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
