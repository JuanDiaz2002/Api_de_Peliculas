import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List<Map<String, dynamic>> movies = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    const apiKey = 'e7c584accebaf4bca595bbfeec321508';
    const apiUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey';

    //final apiUrl = 'https://www.themoviedb.org?api_key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        setState(() {
          movies = List<Map<String, dynamic>>.from(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Películas'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            title: Text(movie["title"]),
            subtitle: Text("Año: ${movie["year"]}"),
          );
        },
      ),
    );
  }
}

void main() async{
  runApp(const MaterialApp(
    home: MovieListWidget(),
  ));
}