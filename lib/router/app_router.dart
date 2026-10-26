import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/authentication_bloc.dart';
import '../screens/book_detail_screen.dart';
import '../screens/books_screen.dart';
import '../screens/home_shell.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import 'stream_listenable.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthenticationBloc authenticationBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: StreamListenable(authenticationBloc.stream),
    redirect: (context, state) {
      final authenticationState = authenticationBloc.state;
      final isOnLogin = state.matchedLocation == '/login';

      if (authenticationState is AuthenticationLoggedIn && isOnLogin) {
        return '/byAuthor';
      }
      if (authenticationState is AuthenticationNotLoggedIn && !isOnLogin) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        redirect: (context, state) =>
            state.uri.path == '/' ? '/byAuthor' : null,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => HomeShell(child: child),
            routes: [
              GoRoute(
                path: 'byAuthor',
                name: 'byAuthor',
                builder: (context, state) => const BooksScreen(
                  heading: 'Sorted by Author',
                  detailRouteName: 'byAuthorDetail',
                ),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: 'byAuthorDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const BookDetailScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'byTitle',
                name: 'byTitle',
                builder: (context, state) => const BooksScreen(
                  heading: 'Sorted by Title',
                  detailRouteName: 'byTitleDetail',
                ),
                routes: [
                  GoRoute(
                    path: 'detail',
                    name: 'byTitleDetail',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const BookDetailScreen(),
                  ),
                ],
              ),
              GoRoute(
                path: 'profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
