import 'package:flutter/material.dart';
import 'package:movies_test/src/domain/models/movie.dart';

class OverView extends StatelessWidget {
  final Movie movie;

  const OverView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
          movie.overview),
    );
  }
}
