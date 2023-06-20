import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_test/src/commons/utils/constants.dart';
import 'package:movies_test/src/commons/widgets/text_title.dart';
import 'package:movies_test/src/modules/movies/provider/movies_provider.dart';
import 'package:movies_test/src/modules/movies/widgets/movies_widgets_export.dart';
import 'package:movies_test/src/router/routes.dart';
import 'package:provider/provider.dart';

import '../../domain/models/movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool gridModeView = true;
  int actualIndex = 0;
  Future<void>? futureGetMovies;
  MoviesProvider? moviesProvider;
  Size? size;

  @override
  void didChangeDependencies() {
    size ??= MediaQuery.of(context).size;
    moviesProvider ??= Provider.of<MoviesProvider>(context);
    futureGetMovies = moviesProvider!.getPopularMovies();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'changeViewHeroTag',
        onPressed: () {
          gridModeView = !gridModeView;
          setState(() {});
        },
        child: Icon(
          gridModeView ? Icons.swipe_rounded : Icons.grid_view_rounded,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: futureGetMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  moviesProvider!.popularMovies.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (moviesProvider!.popularMovies.isEmpty) {
                return _NoDataMessage(moviesProvider: moviesProvider);
              }

              return Column(
                children: [
                  const SizedBox(height: 20),
                  const TextTitle(
                    title: Constants.moviesScreenTitle,
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  if (gridModeView)
                    Expanded(
                      child: AlignedGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 10,
                        itemCount: moviesProvider!.popularMovies.length,
                        itemBuilder: (_, index) {
                          Movie movie = moviesProvider!.popularMovies[index];
                          actualIndex = index;
                          movie.heroId = 'grid-${movie.id}';
                          _checkLastIndexWasShowed(index);
                          return MoviesGridContent(
                            movie: movie,
                            onTapItem: () => _onTapItem(movie),
                          );
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: Swiper(
                        itemCount: moviesProvider!.popularMovies.length,
                        index: actualIndex,
                        loop: false,
                        layout: SwiperLayout.STACK,
                        itemWidth: size!.width * 0.8,
                        itemHeight: size!.height * 0.61,
                        itemBuilder: (_, index) {
                          Movie movie = moviesProvider!.popularMovies[index];
                          movie.heroId = 'swiper-${movie.id}';
                          actualIndex = index;
                          _checkLastIndexWasShowed(index);
                          return MoviesSwiperContent(
                            movie: movie,
                            onTapItem: () => _onTapItem(movie),
                          );
                        },
                      ),
                    ),
                  if (moviesProvider!.isRequesting) ...[
                    const SizedBox(height: 10),
                    const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 10)
                  ],
                ],
              );
            }),
      ),
    );
  }

  void _checkLastIndexWasShowed(int index) {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        if (index == moviesProvider!.popularMovies.length - 1 &&
            !moviesProvider!.isRequesting) {
          moviesProvider!.isRequesting = true;
          moviesProvider?.updateView();
        }
      },
    );
  }

  void _onTapItem(Movie movie) =>
      GoRouter.of(context).pushNamed(Routes.movieDetails, extra: movie);
}

class _NoDataMessage extends StatelessWidget {
  const _NoDataMessage({required this.moviesProvider});

  final MoviesProvider? moviesProvider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          const Text(
            Constants.noData,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28),
          ),
          IconButton(
              onPressed: () {
                moviesProvider?.updateView();
              },
              icon: const Icon(Icons.refresh_rounded)),
          const Spacer()
        ],
      ),
    );
  }
}
