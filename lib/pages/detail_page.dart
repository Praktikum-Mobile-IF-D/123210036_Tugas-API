import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatelessWidget {
  final String movieId;

  DetailPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: FutureBuilder(
        future: fetchMovieDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> movie = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(movie['Title']),
                  Text(movie['Plot']),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchMovieDetails() async {
    final response = await http
        .get(Uri.parse('http://www.omdbapi.com/?apikey=b588e729&i=$movieId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
