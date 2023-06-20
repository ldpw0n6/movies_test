import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_test/src/commons/utils/constants.dart';
import 'package:movies_test/src/domain/models/movie.dart';

class CustomMovieDetailsBanner extends StatelessWidget {
  final Movie movie;

  const CustomMovieDetailsBanner({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: true,
        title: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            )),
        background: CachedNetworkImage(
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator(),
          ),
          fit: BoxFit.cover,
          imageUrl: movie.fullBackdropPath,
          errorWidget: (_, __, ___) => const Text(Constants.imageError),
        ),
      ),
    );
  }
}
