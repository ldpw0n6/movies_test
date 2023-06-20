import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_test/src/domain/models/movie.dart';
import 'package:movies_test/src/domain/models/movie_details.dart';
import 'package:movies_test/src/modules/movies/provider/movies_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/movie_details_export.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    final Movie movie = GoRouterState.of(context).extra as Movie;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        CustomMovieDetailsBanner(movie: movie),
        SliverList(
            delegate: SliverChildListDelegate([
          PosterAndTitle(movie: movie),
          OverView(movie: movie),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextData(text: 'Elenco:')),
          CastingCards(movieId: movie.id),
          FutureBuilder(
            future: moviesProvider.getMovieDetail(movie.id),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                final details = moviesProvider.movieDetails;
                return _DetailsContent(details: details);
              }

              if (snapshot.hasError) {
                return const Text('No se pudieron cargar los datos');
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ])),
      ],
    ));
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({
    // super.key,
    required this.details,
  });

  final MovieDetails? details;

  @override
  Widget build(BuildContext context) {
    if (details == null) {
      return const Text('No se pudieron cargar los datos');
    }

    return Column(
      children: [
        TextData(
            text:
                'Fecha de estreno: ${details?.releaseDate.toString().split(' ')[0]}'),
        TextData(text: 'Duración: ${details?.runtime} minutos'),
        if (details?.belongsToCollection != null)
          TextData(text: 'Saga: ${details?.belongsToCollection!.name}'),
        if (details?.budget != null && details!.budget != 0)
          TextData(text: 'Presupuesto: \$${details?.budget}'),
        if (details?.revenue != null && details!.revenue != 0)
          TextData(text: 'Ganancia: \$${details?.revenue}'),
        const TextData(text: 'Géneros:'),
        TextData(
            text: '${details?.genres.map((genre) => genre.name).join(', ')}'),
        if (details!.homepage.isNotEmpty)
          TextData(text: 'Pagina: ${details?.homepage}'),
        TextData(
            text:
                'Idioma original: ${details?.originalLanguage.toUpperCase()}'),
        TextData(text: 'Popularidad: ${details?.popularity}'),
        if (details!.productionCompanies.isNotEmpty) ...[
          const TextData(text: 'Productoras:'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: details?.productionCompanies.length,
                itemBuilder: (_, index) {
                  final company = details?.productionCompanies[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: 120,
                        height: 120,
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                            imageUrl: company?.fullLogoImg,
                            placeholder: (_, __) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
                      ),
                      SizedBox(
                          width: 120, child: TextData(text: company!.name)),
                    ],
                  );
                },
              ),
            ),
          )
        ],
        if (details!.productionCountries.isNotEmpty) ...[
          const TextData(text: 'País(es):'),
          TextData(
              text: details!.productionCountries
                  .map((pCountries) => pCountries.name)
                  .join(', '))
        ],
        const SizedBox(height: 20)
      ],
    );
  }
}

class TextData extends StatelessWidget {
  const TextData({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
