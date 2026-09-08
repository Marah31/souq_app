import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:souq_app/features/cart/presentation/providers/cart_provider.dart';

class MainShellScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartCount = ref.watch(cartItemCountProvider);

    return Scaffold(
        backgroundColor: Colors.transparent, 
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: (theme.brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white)
                        .withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(36.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavBarItem(
                        icon: Icons.grid_view_rounded,
                        isSelected: navigationShell.currentIndex == 0,
                        onTap: () => navigationShell.goBranch(0),
                      ),
                      _NavBarItem(
                        icon: Icons.shopping_bag_outlined,
                        isSelected: navigationShell.currentIndex == 1,
                        badgeCount: cartCount,
                        onTap: () => navigationShell.goBranch(1),
                      ),
                      _NavBarItem(
                        icon: Icons.favorite_border,
                        isSelected: navigationShell.currentIndex == 2,
                        onTap: () => navigationShell.goBranch(2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final int badgeCount;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.isSelected,
    this.badgeCount = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.iconTheme.color?.withValues(alpha: 0.8),
              size: 24,
            ),
          ),
          if (badgeCount > 0)
            PositionedDirectional(
              top: 6,
              end: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}