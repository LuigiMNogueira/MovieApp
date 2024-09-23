import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movie_horizontal_item.dart';

class MoviesHorizontalList extends StatelessWidget {
  final Result result;
  final Function(int movieId) onMovieTap; // Adiciona o callback onMovieTap

  const MoviesHorizontalList({
    super.key,
    required this.result,
    required this.onMovieTap, // Certifica-se de que o callback é obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result.movies.length,
        itemBuilder: (context, index) {
          final movie = result.movies[index];

          return GestureDetector(
            onTap: () {
              onMovieTap(movie.id); // Chama o callback onMovieTap ao clicar no filme
            },
            child: MovieHorizontalItem(movie: movie),
          );
        },
      ),
    );
  }
}
