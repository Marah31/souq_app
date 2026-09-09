import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/core/localization/l10n_extension.dart';
import 'package:souq_app/core/localization/local_provider.dart';
import 'package:souq_app/core/theme/app_theme.dart';
import 'package:souq_app/core/theme/theme_provider.dart';
import 'package:souq_app/features/products/presentation/models/product_filter_state.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';
import 'package:souq_app/features/products/presentation/screens/widget/product_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(productFilterNotifierProvider.notifier).setSearchQuery('');
  }

  @override
  Widget build(BuildContext context) {
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

          const targetColumnWidth = 220.0;

          final crossAxisCount = (contentWidth / targetColumnWidth).floor().clamp(1, 4);

          final childAspectRatio = crossAxisCount <= 2
              ? 0.62
              : (crossAxisCount == 3 ? 0.68 : 0.74);

          return SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppTheme.maxContentWidth,
                ),
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
                                        color: theme
                                            .colorScheme
                                            .surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                      child: TextField(
                                        controller: _searchController,
                                        onChanged:
                                            filterNotifier.setSearchQuery,
                                        decoration: InputDecoration(
                                          hintText: context.l10n.searchProduct,
                                          prefixIcon: const Icon(
                                            Icons.search_rounded,
                                          ),
                                          suffixIcon:
                                              currentFilter
                                                  .searchQuery
                                                  .isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(
                                                    Icons.clear_rounded,
                                                  ),
                                                  onPressed: _clearSearch,
                                                )
                                              : null,
                                          border: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 14.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        currentFilter.sortOption !=
                                            ProductSortOption.none
                                        ? theme.colorScheme.primaryContainer
                                        : theme
                                              .colorScheme
                                              .surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: PopupMenuButton<ProductSortOption>(
                                    icon: Icon(
                                      Icons.swap_vert_rounded,
                                      color:
                                          currentFilter.sortOption !=
                                              ProductSortOption.none
                                          ? theme.colorScheme.onPrimaryContainer
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    tooltip: context.l10n.sortProduct,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onSelected: filterNotifier.setSortOption,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: ProductSortOption.none,
                                        child: Text(context.l10n.defaultSort),
                                      ),
                                      PopupMenuItem(
                                        value: ProductSortOption.priceLowToHigh,
                                        child: Text(
                                          context.l10n.priceLowToHigh,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: ProductSortOption.priceHighToLow,
                                        child: Text(
                                          context.l10n.priceHighToLow,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value:
                                            ProductSortOption.ratingHighToLow,
                                        child: Text(
                                          context.l10n.ratingHighToLow,
                                        ),
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
                                      padding: const EdgeInsetsDirectional.only(
                                        end: 8.0,
                                      ),
                                      child: ChoiceChip(
                                        label: Text(context.l10n.all),
                                        selected:
                                            currentFilter.selectedCategory ==
                                            null,
                                        onSelected: (_) =>
                                            filterNotifier.selectCategory(null),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ...categories.map(
                                      (cat) => Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                              end: 8.0,
                                            ),
                                        child: ChoiceChip(
                                          label: Text(
                                            context.getLocalizedCategory(cat),
                                          ),
                                          selected:
                                              currentFilter.selectedCategory ==
                                              cat,
                                          onSelected: (isSelected) {
                                            filterNotifier.selectCategory(
                                              isSelected ? cat : null,
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              loading: () => const SizedBox(height: 32),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    filteredProductsAsync.when(
                      loading: () => const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
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
                                  ref.invalidate(fetchProductsProvider);
                                  ref.invalidate(fetchCategoriesProvider);
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
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
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
                                  if (currentFilter.searchQuery.isNotEmpty ||
                                      currentFilter.selectedCategory != null)
                                    OutlinedButton(
                                      onPressed: () {
                                        filterNotifier.resetFilters();
                                        _searchController.clear();
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
                          sliver: SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 16.0,
                              crossAxisSpacing: 16.0,
                              childAspectRatio: childAspectRatio,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final product = products[index];
                                final heroTag = 'hero_home_${product.id}_$index';
                                return ProductCard(
                                  key: ValueKey(product.id),
                                  product: product,
                                  heroTag: heroTag,
                                  onTap: () {
                                    context.push(
                                      '/product/${product.id}',
                                      extra: heroTag,
                                    );
                                  },
                                );
                              },
                              childCount: products.length,
                              addAutomaticKeepAlives: false,
                              addRepaintBoundaries: true,
                            ),
                          ),
                        );
                      },
                    ),
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