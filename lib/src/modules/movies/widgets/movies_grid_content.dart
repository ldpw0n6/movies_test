import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_test/src/domain/models/movie.dart';

class MoviesGridContent extends StatelessWidget {
  const MoviesGridContent({Key? key, required this.movie, this.onTapItem})
      : super(key: key);

  final Movie movie;
  final VoidCallback? onTapItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                  height: 240,
                  child: Hero(
                    tag: movie.heroId!,
                    child: CachedNetworkImage(
                      imageUrl: movie.fullPosterImg,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  )),
            ),
            Text(
              movie.originalTitle,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
