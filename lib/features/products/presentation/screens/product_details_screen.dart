import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(fetchProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product #$productId'),
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (products) {
          final product = products.firstWhere(
            (p) => p.id == productId,
            orElse: () => throw Exception('Product not found'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(product.description),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    final messenger = ScaffoldMessenger.of(context);
                    final router = GoRouter.of(context);

                    ref.read(cartNotifierProvider.notifier).addToCart(product);
                    messenger.removeCurrentSnackBar();

                    final controller = messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          '${product.title} added to cart!',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        dismissDirection: DismissDirection.horizontal,
                        action: SnackBarAction(
                          label: 'View Cart',
                          onPressed: () {
                            messenger.hideCurrentSnackBar();
                            router.go('/cart');
                          },
                        ),
                      ),
                    );

                    Future.delayed(const Duration(seconds: 2), () {
                      controller.close();
                    });
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}