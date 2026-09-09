import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/localization/l10n_extension.dart';
import 'package:souq_app/core/routing/app_router.dart';
import 'package:souq_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;
  final String? heroTag;

  const ProductDetailScreen({super.key, required this.productId, this.heroTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(fetchProductsProvider);
    final theme = Theme.of(context);
    final effectiveHeroTag = heroTag ?? 
            (GoRouterState.of(context).extra as String?) ?? 
            'product_image_$productId';

    return productsAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 64,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.errorMessageTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10n.errorMessageSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(fetchProductsProvider),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(context.l10n.retry),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (products) {
        final product = products.cast<ProductEntity?>().firstWhere(
          (p) => p?.id == productId,
          orElse: () => null,
        );

        if (product == null) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.l10n.productNotFound,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.errorMessageNoProductSearch,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: Text(context.l10n.goBack),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 320,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  
                  child: Hero(
                    tag: effectiveHeroTag,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.primary.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.broken_image_rounded,
                        size: 48,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(
                        product.category[0].toUpperCase() +
                            product.category.substring(1),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating.rate}',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${product.rating.count})',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  product.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),

                const Divider(),
                const SizedBox(height: 12),

                Text(
                  context.l10n.description,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          bottomSheet: Container(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Container(
                width: double.infinity,
                height: 54,
                color: Colors.transparent, 
                child: FilledButton.icon(
                onPressed: () {
                  final router = GoRouter.of(context);
                  final theme = Theme.of(context);

                  ref.read(cartNotifierProvider.notifier).addToCart(product);

                  final messenger = rootScaffoldMessengerKey.currentState;
                  if (messenger == null) return;

                  messenger.clearSnackBars();

                  messenger.showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      elevation: 4,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(
                          color: theme.colorScheme.primary.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: theme.colorScheme.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              context.l10n.addedToCart(product.title),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      action: SnackBarAction(
                        label: context.l10n.viewCart,
                        textColor: theme.colorScheme.primary,
                        onPressed: () {
                          rootScaffoldMessengerKey.currentState?.clearSnackBars();
                          router.go('/cart');
                        },
                      ),
                    ),
                  );

                  Timer(const Duration(milliseconds: 2500), () {
                    rootScaffoldMessengerKey.currentState?.clearSnackBars();
                  });
                },
                                  
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: Text(
                    context.l10n.addToCart,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
                  ),
        );
      },
    );
  }
}