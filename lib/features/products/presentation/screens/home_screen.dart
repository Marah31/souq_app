import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/localization/l10n_extension.dart';
import 'package:souq_app/core/localization/local_provider.dart';
import 'package:souq_app/core/theme/theme_provider.dart';
import 'package:souq_app/features/products/presentation/models/product_filter_state.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';
import 'package:souq_app/features/products/presentation/screens/widget/product_card.dart';
import 'package:souq_app/core/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredProductsAsync = ref.watch(filteredProductsProvider);
    final categoriesAsync = ref.watch(fetchCategoriesProvider);
    final currentFilter = ref.watch(productFilterNotifierProvider);
    final filterNotifier = ref.read(productFilterNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded),
            tooltip: context.l10n.switchLanguage,
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLanguage();
            },
          ),
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            tooltip: context.l10n.toggleTheme,
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(width: 8),
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

          return SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: outerPadding,
                          vertical: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0), 
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(30.0), 

                                      ),
                                    child: TextField(
                                      onChanged: filterNotifier.setSearchQuery,
                                      decoration: InputDecoration(
                                        hintText: context.l10n.searchProduct,
                                        prefixIcon: const Icon(Icons.search_rounded),
                                        suffixIcon: currentFilter.searchQuery.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.clear_rounded),
                                                onPressed: () => filterNotifier.setSearchQuery(''),
                                              )
                                            : null,
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),),
                                const SizedBox(width: 10),

                                Container(
                                  decoration: BoxDecoration(
                                    color: currentFilter.sortOption != ProductSortOption.none
                                        ? theme.colorScheme.primaryContainer
                                        : theme.colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: PopupMenuButton<ProductSortOption>(
                                    icon: Icon(
                                      Icons.swap_vert_rounded,
                                      color: currentFilter.sortOption != ProductSortOption.none
                                          ? theme.colorScheme.onPrimaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    tooltip: 'Sort Products',
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onSelected: filterNotifier.setSortOption,
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: ProductSortOption.none,
                                        child: Text('Default'),
                                      ),
                                      const PopupMenuItem(
                                        value: ProductSortOption.priceLowToHigh,
                                        child: Text('Price: Low to High'),
                                      ),
                                      const PopupMenuItem(
                                        value: ProductSortOption.priceHighToLow,
                                        child: Text('Price: High to Low'),
                                      ),
                                      const PopupMenuItem(
                                        value: ProductSortOption.ratingHighToLow,
                                        child: Text('Highest Rated'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                          categoriesAsync.when(
                            data: (categories) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                                    child: ChoiceChip(
                                      label: Text(context.l10n.all),
                                      selected: currentFilter.selectedCategory == null,
                                      onSelected: (_) => filterNotifier.selectCategory(null),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),

                                  ...categories.map(
                                    (cat) => Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 8.0),
                                      child: ChoiceChip(
                                        label: Text(context.getLocalizedCategory(cat)),
                                        selected: currentFilter.selectedCategory == cat,
                                        onSelected: (_) => filterNotifier.selectCategory(cat),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            loading: () => const SizedBox(height: 32),
                            error: (_, __) => const SizedBox.shrink(),
                          )
                          ],
                        ),
                      ),
                    ),

                  filteredProductsAsync.when(
                    loading: () => const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, stackTrace) => SliverFillRemaining(
                      hasScrollBody: false,
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
                              textAlign: TextAlign.center,
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
                              onPressed: () {
                                ref.invalidate(filteredProductsProvider);
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: Text(context.l10n.retry), 
                            ),
                          ],
                        ),
                      ),
                    ),
                    data: (products) {
                      if (products.isEmpty) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 64,
                                  color: theme.colorScheme.outline,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  context.l10n.noProductsFound, 
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  context.l10n.noProductsFoundSubtitle, 
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                if (currentFilter.searchQuery.isNotEmpty || currentFilter.selectedCategory != null)
                                  OutlinedButton(
                                    onPressed: () {
                                      filterNotifier.resetFilters(); 
                                    },
                                    child: Text(context.l10n.clearFilters),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: EdgeInsets.only(
                          left: outerPadding,
                          right: outerPadding,
                          bottom: 100.0,
                        ),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 24.0,
                          crossAxisSpacing: 20.0,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              onTap: () => context.push('/product/${product.id}'),
                            );
                          },
                          childCount: products.length,
                        ),
                      );
                    },
                  )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}