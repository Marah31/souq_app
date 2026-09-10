import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/localization/l10n_extension.dart';
import 'package:souq_app/core/theme/app_theme.dart';
import 'package:souq_app/features/cart/presentation/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartNotifierProvider);
    final subtotal = ref.watch(cartTotalAmountProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    const double freeShippingThreshold = 100.0;
    final shippingFee = subtotal > 0 ? (subtotal >= freeShippingThreshold ? 0.0 : 10.0) : 0.0;
    final grandTotal = subtotal + shippingFee;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: context.l10n.goBack,
          onPressed: () => context.go('/'),
        ),
        title: Text(
          context.l10n.myCart,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () => cartNotifier.clearCart(),
              child: Text(
                context.l10n.clearCart,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: cartItems.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
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
                                Icons.shopping_bag_outlined,
                                size: 64,
                                color: theme.colorScheme.primary.withValues(alpha: 0.6),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              context.l10n.cartEmpty,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              context.l10n.cartEmptySubMessage,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: () => context.go('/'),
                              icon: const Icon(Icons.storefront_rounded),
                              label: Text(context.l10n.startShopping),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        color: subtotal >= freeShippingThreshold
                            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4)
                            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        child: Row(
                          children: [
                            Icon(
                              subtotal >= freeShippingThreshold
                                  ? Icons.local_shipping_rounded
                                  : Icons.info_outline_rounded,
                              size: 20,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                subtotal >= freeShippingThreshold
                                    ? context.l10n.freeShippingMessage
                                    : '${context.l10n.add} \$${(freeShippingThreshold - subtotal).toStringAsFixed(2)} ${context.l10n.shippingProgress}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                          itemCount: cartItems.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            final product = item.product;

                            return Card(
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
                                ),
                              ),
                              child: InkWell(
                                onTap: (){
                                  final prefix = 'cart';
                                  context.push(
                                    '/product/${product.id}?heroPrefix=$prefix',
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: Container(
                                          width: 68,
                                          height: 68,
                                          color: theme.colorScheme.surfaceContainerHighest,
                                          padding: const EdgeInsets.all(6.0),
                                          child: CachedNetworkImage(
                                            imageUrl: product.image,
                                            fit: BoxFit.contain,
                                            memCacheWidth: 200,
                                            placeholder: (context, url) => Center(
                                              child: SizedBox(
                                                width: 16,
                                                height: 16,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                                                ),
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Icon(
                                              Icons.broken_image_rounded,
                                              size: 20,
                                              color: theme.colorScheme.error,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 14),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '\$${product.price.toStringAsFixed(2)}',
                                              style: theme.textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: theme.colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.surface,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              constraints: const BoxConstraints(),
                                              padding: const EdgeInsets.all(6),
                                              icon: Icon(
                                                item.quantity == 1
                                                    ? Icons.delete_outline_rounded
                                                    : Icons.remove_rounded,
                                                size: 18,
                                                color: item.quantity == 1 ? theme.colorScheme.error : null,
                                              ),
                                              onPressed: () => cartNotifier.updateQuantity(
                                                product.id,
                                                item.quantity - 1,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                              child: Text(
                                                '${item.quantity}',
                                                style: theme.textTheme.titleSmall?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              constraints: const BoxConstraints(),
                                              padding: const EdgeInsets.all(6),
                                              icon: const Icon(Icons.add_rounded, size: 18),
                                              onPressed: () => cartNotifier.updateQuantity(
                                                product.id,
                                                item.quantity + 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: const EdgeInsets.only(bottom: 12),
                              shape: const Border(),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.l10n.total,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '\$${grandTotal.toStringAsFixed(2)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(context.l10n.subtotal, style: theme.textTheme.bodyMedium),
                                    Text('\$${subtotal.toStringAsFixed(2)}'),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(context.l10n.shipping, style: theme.textTheme.bodyMedium),
                                    Text(
                                      shippingFee == 0.0 ? context.l10n.free : '\$${shippingFee.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: shippingFee == 0.0 ? Colors.green : null,
                                        fontWeight: shippingFee == 0.0 ? FontWeight.bold : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: FilledButton.icon(
                                onPressed: () {
                                  // proceed to checkout
                                },
                                icon: const Icon(Icons.arrow_forward_rounded),
                                label: Text(
                                  '${context.l10n.checkout} (\$${grandTotal.toStringAsFixed(2)})',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}