import 'package:flutter/material.dart';
import 'package:movie_app/services/api_services.dart';

class GenreFilterPage extends StatefulWidget {
  const GenreFilterPage({Key? key}) : super(key: key);

  @override
  State<GenreFilterPage> createState() => _GenreFilterPageState();
}

class _GenreFilterPageState extends State<GenreFilterPage> {
  final ApiServices apiServices = ApiServices();
  String? selectedGenre;
  late Future<List<String>> genresFuture;

  @override
  void initState() {
    genresFuture = apiServices.getGenres();
    super.initState();
  }

  // Modifique a assinatura da função para aceitar um String opcional (String?)
  void onGenreSelected(String? genre) {
    setState(() {
      selectedGenre = genre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter by Genre'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<String>>(
            future: genresFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading genres');
              } else {
                final genres = snapshot.data!;
                return DropdownButton<String>(
                  value: selectedGenre,
                  hint: const Text('Select a genre'),
                  onChanged: onGenreSelected, // Callback atualizado
                  items: genres.map((String genre) {
                    return DropdownMenuItem<String>(
                      value: genre,
                      child: Text(genre),
                    );
                  }).toList(),
                );
              }
            },
          ),
          if (selectedGenre != null) ...[
            const SizedBox(height: 20),
            Text('Movies in the genre: $selectedGenre'),
            // Aqui você pode exibir os filmes filtrados pelo gênero selecionado
          ],
        ],
      ),
    );
  }
}
