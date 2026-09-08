import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:souq_app/features/products/presentation/screens/home_screen.dart';
import 'package:souq_app/features/products/presentation/screens/product_details_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import 'main_shell_scaffold.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cart',
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/product/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final idString = state.pathParameters['id'] ?? '0';
          final productId = int.tryParse(idString) ?? 0;
          return ProductDetailScreen(productId: productId);
        },
      ),
    ],
  );
});