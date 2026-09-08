import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';
import 'package:souq_app/features/products/presentation/screens/widget/product_card.dart';
import 'package:souq_app/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final filteredProductsAsync = ref.watch(filteredProductsProvider);
    final categoriesAsync = ref.watch(fetchCategoriesProvider);
    final currentFilter = ref.watch(productFilterNotifierProvider);
    final filterNotifier = ref.read(productFilterNotifierProvider.notifier);

    final screenWidth = MediaQuery.sizeOf(context).width;
    final outerPadding = AppTheme.pagePadding(screenWidth);

    final contentWidth = screenWidth > AppTheme.maxContentWidth
        ? AppTheme.maxContentWidth
        : screenWidth;
    final crossAxisCount = (contentWidth / 190).floor().clamp(2, 5);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(    
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('/home/marah/Projects/flutter-internship/souq_app/lib/assets/images/rm183-techi-02.jpg'),
            //   fit: BoxFit.cover, 
            // ),
          ),
        
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppTheme.maxContentWidth),
            child: CustomScrollView(
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
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: TextField(
                            onChanged: filterNotifier.setSearchQuery,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: const Icon(Icons.search_rounded),
                              suffixIcon: currentFilter.searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear_rounded),
                                      onPressed: () => filterNotifier.setSearchQuery(''),
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 14.0,
                              ),
                            ),
                          ),
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
                                    label: const Text('All'),
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
                                      label: Text(
                                        cat[0].toUpperCase() + cat.substring(1),
                                      ),
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
                        ),
                      ],
                    ),
                  ),
                ),

                filteredProductsAsync.when(
                  loading: () => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => SliverFillRemaining(
                    child: Center(child: Text('Failed to load: $err')),
                  ),
                  data: (products) {
                    if (products.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('No products match your criteria.'),
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
                            onTap: () {
                              context.push('/product/${product.id}');
                            },
                          );
                        },
                        childCount: products.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}