import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/features/random_quote/presentation/pages/favorites_page.dart';
import 'package:quotes/features/random_quote/presentation/pages/quotes_page.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialPageRoute:
        return MaterialPageRoute(
          builder: (_) => const QuotesPage(),
          settings: settings,
        );

      case AppRoutes.favoritesPageRoute:
        return MaterialPageRoute(
          builder: (_) => const FavoraitesPage(),
          settings: settings,
        );

      default:
        return _unDefinedRoute(settings);
    }
  }

  static Route? _unDefinedRoute(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text(AppStrings.noRouteFound),
          ),
        ),
        settings: settings,
      );
}
