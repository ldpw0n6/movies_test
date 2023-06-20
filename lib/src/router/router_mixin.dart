import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_test/src/modules/home/home_screen.dart';
import 'package:movies_test/src/modules/movies/movies_screen.dart';
import 'package:movies_test/src/modules/movies_details/movie_details_screen.dart';

import 'routes.dart';

mixin RouterMixin {
  GoRouter? _router;
  final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  GoRouter get router => _router ??= GoRouter(
        initialLocation: '/${Routes.home}',
        navigatorKey: parentNavigatorKey,
        routes: [
          /* ShellRoute(
              navigatorKey: rootNavigatorKey,
              // builder: (context, state, child) => RootScaffold(child: child),
              routes: [
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: '/',
                  name: Routes.home,
                  builder: (_, __) => const HomeScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: '/${Routes.flightDates}',
                  name: Routes.flightDates,
                  builder: (_, __) => const FlightDatesScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: '/${Routes.passengerData}',
                  name: Routes.passengerData,
                  builder: (_, __) => const PassengerDataScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: '/${Routes.pay}',
                  name: Routes.pay,
                  builder: (_, __) => const PayFlightScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: '/${Routes.paySuccess}',
                  name: Routes.paySuccess,
                  builder: (_, __) => const AcceptedPayFlightScreen(),
                ),
              ]),*/
          GoRoute(
            parentNavigatorKey: parentNavigatorKey,
            path: '/${Routes.home}',
            name: Routes.home,
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
              parentNavigatorKey: parentNavigatorKey,
              path: '/${Routes.movies}',
              name: Routes.movies,
              builder: (_, __) => const MoviesScreen()),
          GoRoute(
              parentNavigatorKey: parentNavigatorKey,
              path: '/${Routes.movieDetails}',
              name: Routes.movieDetails,
              builder: (_, __) => const MovieDetailsScreen()),
        ],
      );
}
