import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/localization/l10n_extension.dart';
import 'package:souq_app/core/theme/app_theme.dart';
import 'package:souq_app/features/favorite/presentation/providers/favorite_provider.dart';
import 'package:souq_app/features/products/presentation/screens/widget/product_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favoriteProducts = ref.watch(favoriteProductsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: context.l10n.goBack,
          onPressed: () => context.go('/'),
        ),
        title: Text(
          context.l10n.savedItems,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (favoriteProducts.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${favoriteProducts.length} ${context.l10n.items}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final outerPadding = AppTheme.pagePadding(screenWidth);

          final contentWidth = screenWidth > AppTheme.maxContentWidth
              ? AppTheme.maxContentWidth
              : screenWidth;

          final crossAxisCount = (contentWidth / 200).floor().clamp(2, 5);

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 64,
                      color: theme.colorScheme.primary.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.favoriteEmpty,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      context.l10n.favoriteEmptySubMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.storefront_rounded),
                    label: Text(context.l10n.explore),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: outerPadding,
                      right: outerPadding,
                      top: 16.0,
                      bottom: 100.0,
                    ),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 24.0, 
                      crossAxisSpacing: 20.0, 
                      childCount: favoriteProducts.length,
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            context.push('/product/${product.id}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}